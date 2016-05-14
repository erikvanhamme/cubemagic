# Copyright 2016 Erik Van Hamme
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'tsort'

class TsortableHash < Hash
  include TSort

  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

class Item
  attr_accessor :valid

  def initialize
    @valid = true
  end
end

class ConditionOption < Item
  attr_accessor :option, :invert

  def initialize(option, invert)
    super()
    @option = option
    @invert = invert
  end

  def met?(project)
    option_present = false
    if project.options != nil
      project.options.each do |option|
        if option.name == @option
          option_present = true
          break
        end
      end
    end
    option_present ^ @invert
  end
end

class ConditionDefine < Item
  attr_accessor :define, :invert

  def initialize(define, invert)
    super()
    @define = define
    @invert = invert
  end

  def met?(project)
    # TODO: Implement me.
    false
  end
end

class ConditionDefineValue < Item
  attr_accessor :define, :value, :invert

  def initialize(define, value, invert)
    super()
    @define = define
    @value = value
    @invert = invert
  end

  def met?(project)
    # TODO: Implement me.
    false
  end
end

class ConditionUse <  Item
  attr_accessor :use, :invert

  def initialize(use, invert)
    super()
    @use = use
    @invert = invert
  end

  def met?(project)
    # TODO: Implement me.
    false
  end
end

class ComponentBase < Item
  attr_accessor :libs, :sys_incs, :sys_srcs, :srcs, :incs, :defines, :templates
end

class Conditional < ComponentBase
  attr_accessor :conditions

  def conditions_met?(project)
    met = false
    if @conditions != nil
      met = true
      @conditions.each do |condition|
        unless condition.met?(project)
          met = false
          break
        end
      end
    end
    met
  end
end

class Component < ComponentBase
  attr_accessor :name, :depends, :conditionals, :flash_base, :sram_base, :ccm_base, :itcm_base, :dtcm_base, :flash,
                :sram, :ccm, :itcm, :dtcm, :type, :auto, :parent

  def initialize(name, parent, type)
    super()
    @name = name
    @parent = parent
    @type = type
  end

  def get_dependencies
    depends = []

    if @depends != nil
      @depends.each do |dependency|
        depends << dependency
        depends << dependency.get_dependencies
      end

      depends.flatten!
      depends.uniq!
    end

    depends
  end
end

class Define < Item
  attr_accessor :name, :value

  def initialize(name, value)
    super()
    @name = name
    @value = value
  end
end

class Option < Item
  attr_accessor :name, :value

  def initialize(name, value)
    super()
    @name = name
    @value = value
  end
end

class Template < Item
  attr_accessor :template, :auto

  def initialize(template, auto)
    super()
    @template = template
    @auto = auto
  end
end

class Cube < Item
  attr_accessor :name, :version, :root, :components
end

class SrcDir < Item
  attr_accessor :components, :path
end

class Project < Item
  attr_accessor :name, :cube, :mode, :src_dirs, :uses, :defines, :options, :oocd_path, :gcc_path, :oocd_cfgs,
                :all_components

  def abort_if_invalid
    valid = true
    lines = []

    instances = ObjectSpace.each_object(Item).to_a
    instances.each do |instance|
      unless instance.valid
        valid = false

        if instance.is_a?(Project)
          lines << ("  Project with name: #{instance.name}")
        end

        if instance.is_a?(Component)
          lines << ("  Component with name: #{instance.name}")
        end

        # TODO: Complete the reporting on validity check.
      end
    end

    unless valid
      puts 'Aborting because the following items are not valid:'
      lines.each do |line|
        puts line
      end
      exit 1
    end
  end

  def parse_project_descriptor(file)
    if File.exist?(file)
      project_file = File.read(file)
      project_dsl = DSL_Project.new(self)
      project_dsl.instance_eval(project_file, file)
    else
      puts "WARNING: project descriptor file '#{file}' does not exist."
      @valid = false
    end
  end

  def parse_cube_descriptor(file)
    if File.exist?(file)
      cube_file = File.read(file)
      cube = Cube.new
      cube_dsl = DSL_Cube.new(cube)
      cube_dsl.instance_eval(cube_file, file)
      cube
    else
      puts "WARNING: cube descriptor file '#{file}' does not exist."
      @valid = false
      nil
    end
  end

  def parse_src_dir_descriptor(file)
    if File.exist?(file)
      src_dir_file = File.read(file)
      src_dir = SrcDir.new
      src_dir_dsl = DSL_SrcDir.new(src_dir)
      src_dir_dsl.instance_eval(src_dir_file, file)
      src_dir
    else
      puts "WARNING: src dir descriptor file '#{file}' does not exist."
      @valid = false
      nil
    end
  end

  def collect_components
    if @all_components == nil
      @all_components = Hash.new

      # Collect all components from cube.
      if self.cube.components != nil
        self.cube.components.each do |component|
          @all_components[component.name] = component
        end
      end

      # Collect all components from src dirs.
      if self.src_dirs != nil
        self.src_dirs.each do |src_dir|
          if src_dir.components != nil
            src_dir.components.each do |component|
              @all_components[component.name] = component
            end
          end
        end
      end
    end
  end

  def parse_descriptors(file)
    # Load and parse project file.
    parse_project_descriptor(file)

    # Replace the cube value with the loaded and parsed cube contents.
    @cube = parse_cube_descriptor("#{$cubemagic_dir}/#{@cube}.dsl.rb")

    # Replace the src_dirs values with the loaded and parsed src_dir contents.
    if @src_dirs != nil
      @src_dirs.collect! do |src_dir|
        parse_src_dir_descriptor("#{src_dir}/#{src_dir}.dsl.rb")
      end
    end

    # Collect the full component list.
    collect_components

    # Run validity check at this point.
    abort_if_invalid
  end

  def verify_depends
    # We verify the dependencies by running a topological sort on them.
    # If we get an exception, it means there is a cyclic dependency.
    ok = true

    # Fill the TsortableHash.
    dependency_hash = TsortableHash.new
    @all_components.each do |name, component|
      deps = component.depends
      if deps == nil
        deps = []
      end
      dependency_hash[name] = deps
    end

    # Run the sort, capture the exception and get the component names out of the exception in case
    # of a circular dependency.
    begin
      dependency_hash.tsort
    rescue TSort::Cyclic => error
      ok = false

      # TODO: verify regex if proper format of module names is known.
      names = error.to_s.downcase.scan(/"[a-z][a-z0-9]*"/)

      names.each do |name|
        name.gsub!(/"/, '')
        @all_components[name].valid = false unless @all_components[name] == nil
      end

      puts "WARNING: cyclic dependency detected between components: #{names.to_s}"
    end
    ok
  end

  def replace_depends
    unless verify_depends
      return
    end

    # Replace the depends strings of all components with the real link to the component.
    # Be on the lookout for missing components.
    @all_components.each do |key, component|

      if component.depends != nil
        component.depends.collect! do |depends|
          depends_component = all_components[depends]

          # Missing component check.
          if depends_component == nil
            puts "WARNING: component with name: #{key} specifies a dependency on: #{depends} which does not exist."
            component.valid = false
            return
          end

          depends_component
        end
      end
    end

    # Verify validity at this point.
    abort_if_invalid
  end

  def replace_expand_uses
    if self.uses == nil
      self.uses = []
    end

    @all_components.each do |name, component|
      if (component.auto != nil) && component.auto
        self.uses << name
      end
    end

    self.uses.uniq!

    self.uses.collect! do |use|
      if @all_components[use] == nil
        puts "WARNING: project use flag: #{use} points to a non-existent component."
        self.valid = false
        return
      end

      @all_components[use]
    end

    add_use = []
    self.uses.each do |use|
      add_use << use.get_dependencies
    end
    self.uses << add_use
    self.uses.flatten!
    self.uses.uniq!

    # Run validity check at this point.
    abort_if_invalid
  end

  def verify_uses
    chip = []
    chipfamily = []
    board = []

    self.uses.each do |use|
      if use.type == 'chip'
        chip << use.name
      end
      if use.type == 'chipfamily'
        chipfamily << use.name
      end
      if use.type == 'board'
        board << use.name
      end
    end

    if chip.length == 0
      puts 'WARNING: no chip selected in use flags of the project.'
      self.valid = false
    end
    if chip.length > 1
      puts "WARNING: more then one chip selected in use flags of project: #{chip.to_s}"
      self.valid = false
    end

    if chipfamily.length == 0
      puts 'WARNING: no chipfamily selected in use flags of the project.'
      self.valid = false
    end
    if chipfamily.length > 1
      puts "WARNING: more then one chipfamily selected in use flags of project: #{chipfamily.to_s}"
      self.valid = false
    end

    if board.length > 1
      puts "WARNING: more then one board selected in use flags of project: #{board.to_s}"
      self.valid = false
    end

    # Run validity check at this point.
    abort_if_invalid
  end

  def prefix_array(array, prefix)
    if array != nil
      array.collect! do |item|
        prefix + item
      end
    end
  end

  def prefix_templates_array(array, prefix)
    if array != nil
      array.each do |template|
        template.template = prefix + template.template
      end
    end
  end

  def prefix_base_component(component, prefix)
    prefix_array(component.sys_incs, prefix)
    prefix_array(component.sys_srcs, prefix)
    prefix_array(component.incs, prefix)
    prefix_array(component.srcs, prefix)
    prefix_array(component.libs, prefix)
    prefix_templates_array(component.templates, prefix)
  end

  def prefix_component(component, prefix)
    prefix_base_component(component, prefix)
    if component.conditionals != nil
      component.conditionals.each do |conditional|
        prefix_base_component(conditional, prefix)
      end
    end
  end

  def prefix_files_paths
    prefix = 'cube' + self.cube.name + '/'
    self.cube.components.each do |component|
      prefix_component(component, prefix)
    end

    if self.src_dirs != nil
      self.src_dirs.each do |src_dir|
        prefix = src_dir.path + '/'
        src_dir.components.each do |component|
          prefix_component(component, prefix)
        end
      end
    end
  end

  def initialize(file)
    super()
    parse_descriptors(file)
    replace_depends
    replace_expand_uses
    verify_uses
    prefix_files_paths
  end
end