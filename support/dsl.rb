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

class DSL_Item
  def initialize(item)
    @item = item
  end

  def parse_lib(item, lib)
    if item.libs == nil
      item.libs = []
    end
    item.libs << lib
    # TODO: Add validation.
  end

  def parse_sys_inc(item, sys_inc)
    if item.sys_incs == nil
      item.sys_incs = []
    end
    item.sys_incs << sys_inc
    # TODO: Add validation.
  end

  def parse_sys_src(item, sys_src)
    if item.sys_srcs == nil
      item.sys_srcs = []
    end
    item.sys_srcs << sys_src
    # TODO: Add validation.
  end

  def parse_inc(item, inc)
    if item.incs == nil
      item.incs = []
    end
    item.incs << inc
    # TODO: Add validation.
  end

  def parse_src(item, src)
    if item.srcs == nil
      item.srcs = []
    end
    item.srcs << src
    # TODO: Add validation.
  end

  def parse_define(item, name, value)
    if item.defines == nil
      item.defines = []
    end
    define = Define.new(name, value)
    item.defines << define
    # TODO: Add validation.
  end

  def parse_template(item, file, auto)
    if item.templates == nil
      item.templates = []
    end
    if auto != nil && auto.downcase == 'auto'
      auto_bool = true
    else
      auto_bool = false
    end
    template = Template.new(file, auto_bool)
    item.templates << template
    # TODO: Add validation.
  end

  def parse_component(item, name, type, &block)
    if item.components == nil
      item.components = []
    end
    component = Component.new(name, item, type)
    component_dsl = DSL_Component.new(component)
    component_dsl.instance_eval(&block)
    item.components << component
    # TODO: Add validation for name.
  end
end

class DSL_ComponentBase < DSL_Item
  def lib(lib)
    parse_lib(@item, lib)
  end

  def sys_inc(sys_inc)
    parse_sys_inc(@item, sys_inc)
  end

  def sys_src(sys_src)
    parse_sys_src(@item, sys_src)
  end

  def inc(inc)
    parse_inc(@item, inc)
  end

  def src(src)
    parse_src(@item, src)
  end

  def define(name, value = nil)
    parse_define(@item, name, value)
  end

  def template(template, auto = nil)
    parse_template(@item, template, auto)
  end
end

class DSL_Conditional < DSL_ComponentBase

  def condition_option_set(option)
    if @item.conditions == nil
      @item.conditions = []
    end
    condition = ConditionOption.new(option, false)
    @item.conditions << condition
    #TODO: add validation for option.
  end

  def condition_option_unset(option)
    if @item.conditions == nil
      @item.conditions = []
    end
    condition = ConditionOption.new(option, true)
    @item.conditions << condition
    #TODO: add validation for option.
  end
end

class DSL_Component < DSL_ComponentBase

  def depends(depends)
    if @item.depends == nil
      @item.depends = []
    end
    @item.depends << depends
    #TODO: Add validation for depends.
  end

  def conditional(&block)
    if @item.conditionals == nil
      @item.conditionals = []
    end
    conditional = Conditional.new
    conditional_dsl = DSL_Conditional.new(conditional)
    conditional_dsl.instance_eval(&block)
    @item.conditionals << conditional
  end

  def auto
    @item.auto = true
  end
end

class DSL_ChipFamily < DSL_Component

  def check(value, name)
    unless value.is_a?(Integer)
      puts "WARNING: #{name} in chipfamily is not valid."
      @item.valid = false
    end
    value
  end

  def flash_base(flash_base)
    @item.flash_base = check(flash_base, 'flash_base')
  end

  def sram_base(sram_base)
    @item.sram_base = check(sram_base, 'sram_base')
  end

  def ccm_base(ccm_base)
    @item.ccm_base = check(ccm_base, 'ccm_base')
  end

  def itcm_base(itcm_base)
    @item.itcm_base = check(itcm_base, 'itcm_base')
  end

  def dtcm_base(dtcm_base)
    @item.dtcm_base = check(dtcm_base, 'dtcm_base')
  end

end

class DSL_Chip < DSL_Component

  def check(size, name)

    if (size.is_a? String) && (size =~ /^[0-9]+[kM]$/)

      if size =~ /^[0-9]+k$/
        size.chomp!('k')
        size = (size.to_i) * 1024
      end

      if size =~ /^[0-9]+M$/
        size.chomp!('M')
        size = (size.to_i) * 1024 * 1024
      end

    else
      puts "WARNING: #{name} in chip descriptor is not valid."
      @item.valid = false
      size = 0
    end

    size
  end

  def flash(flash)
    @item.flash = check(flash, 'flash')
  end

  def sram(sram)
    @item.sram = check(sram, 'sram')
  end

  def ccm(ccm)
    @item.ccm = check(ccm, 'ccm')
  end

  def itcm(itcm)
    @item.itcm = check(itcm, 'itcm')
  end

  def dtcm(dtcm)
    @item.dtcm = check(dtcm, 'dtcm')
  end
end

class DSL_Cube < DSL_Item

  def cube(name, version, root, &block)
    @item.name = name
    @item.version = version
    @item.root = root
    instance_eval(&block)
    unless name.downcase =~ /^f[012347]$/
      puts 'WARNING: cube name in cube descriptor is not valid.'
      @item.valid = false
    end
    unless version.downcase =~ /^v[0-9]+\.[0-9]+\.[0-9]+$/
      puts 'WARNING: cube version in cube descriptor is not valid.'
      @item.valid = false
    end
    # TODO: Add validation for root.
  end

  def component(name, &block)
    parse_component(@item, name, 'component', &block)
  end

  def chipfamily(name, &block)
    if @item.components == nil
      @item.components = []
    end
    component = Component.new(name, @item, 'chipfamily')
    component_dsl = DSL_ChipFamily.new(component)
    component_dsl.instance_eval(&block)
    @item.components << component
    # TODO: Add validation for name.
  end

  def chip(name, &block)
    if @item.components == nil
      @item.components = []
    end
    component = Component.new(name, @item, 'chip')
    component_dsl = DSL_Chip.new(component)
    component_dsl.instance_eval(&block)
    @item.components << component
    # TODO: Add validation for name.
  end

  def board(name, &block)
    parse_component(@item, name, 'board', &block)
  end
end

class DSL_SrcDir < DSL_Item

  def src_dir(path, &block)
    @item.path = path
    instance_eval(&block)
    # TODO: Add validation for path.
  end

  def component(name, &block)
    parse_component(@item, name, 'component', &block)
  end
end

class DSL_Project < DSL_Item

  def project(name, &block)
    @item.name = name
    instance_eval(&block)
    unless name =~ /^[a-zA-Z][a-zA-Z0-9\-_]*$/
      puts 'WARNING: project name is not valid.'
      @item.valid = false
    end
  end

  def cube(name, version)
    @item.cube = 'cubes/cube' + name.downcase + '-' + version.downcase
    unless name.downcase =~ /^f[012347]$/
      puts 'WARNING: cube name in project is not valid.'
      @item.valid = false
    end
    unless version.downcase =~ /^v[0-9]+\.[0-9]+\.[0-9]+$/
      puts 'WARNING: cube version in project is not valid.'
      @item.valid = false
    end
  end

  def mode(mode)
    @item.mode = mode.downcase
    unless mode.downcase =~ /^debug$|^release$/
      puts 'WARNING: mode in project is not valid.'
      @item.valid = false
    end
  end

  def src_dir(src_dir)
    if @item.src_dirs == nil
      @item.src_dirs = []
    end
    @item.src_dirs << src_dir
    # TODO: Add validation of input here.
  end

  def use(use)
    if @item.uses == nil
      @item.uses = []
    end
    @item.uses << use
    # TODO: Add validation of input here.
  end

  def define(name, value = nil)
    parse_define(@item, name, value)
  end

  def option(name, value = nil)
    if @item.options == nil
      @item.options = []
    end
    option = Option.new(name, value)
    @item.options << option
    # TODO: Add validation of input here.
  end

  def oocd_path(oocd_path)
    @item.oocd_path = oocd_path
    # TODO: Add validation of input here.
  end

  def gcc_path(gcc_path)
    @item.gcc_path = gcc_path
    # TODO: Add validation of input here.
  end

  def oocd_cfg(oocd_cfg)
    if @item.oocd_cfgs == nil
      @item.oocd_cfgs = []
    end
    @item.oocd_cfgs << oocd_cfg
    # TODO: Add validation of input here.
  end
end