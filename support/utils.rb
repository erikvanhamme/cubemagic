require 'erb'

class ComponentUsedFilter
  def filter(component, project)
    match = true
    if component == nil || project == nil || project.uses == nil || project.uses.include?(component) == false
      match = false
    end
    match
  end
end

class ComponentCubeFilter
  def filter(component, project)
    match = true
    if component == nil || project == nil || component.parent != project.cube
      match = false
    end
    match
  end
end

class LdScriptGen
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def generate
    File.open('ldscript.ld', 'w+') do |os|
      os.puts ERB.new(File.read("#{$cubemagic_dir}/templates/ldscript.ld.erb"), nil, '-').result(binding)
    end
  end
end

class MakefileGen
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def generate
    File.open('Makefile', 'w+') do |os|
      os.puts ERB.new(File.read("#{$cubemagic_dir}/templates/Makefile.erb"), nil, '-').result(binding)
    end
  end
end

