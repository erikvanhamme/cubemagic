#!/usr/bin/ruby

$cubemagic_dir = File.dirname(__FILE__)

$:.unshift File.expand_path('./support', $cubemagic_dir)

require 'dsl.rb'
require 'project.rb'

require 'zip'

# -- Main Program ------------------------------------------------------------------------------------------------------

project = Project.new(ARGV[0])

class ComponentUsedFilter
  def filter(component, project)
    match = true
    if component == nil || project == nil || project.uses == nil || project.uses.include?(component) == false
      match = false
    end
    match
  end
end

def merge(component_set, what, project, filters = nil)
  merged = []

  if component_set != nil && what != nil && project != nil
    component_set.each do |component|

      if filters != nil
        match = true
        filters.each do |filter|
          unless filter.filter(component, project)
            match = false
            break
          end
        end
        unless match
          next
        end
      end

      case what
        when 'defines'
          merged += component.defines unless component.defines == nil
        when 'libs'
          merged += component.libs unless component.libs == nil
        when 'srcs'
          merged += component.srcs unless component.srcs == nil
        when 'sys_srcs'
          merged += component.sys_srcs unless component.sys_srcs == nil
        when 'incs'
          merged += component.incs unless component.incs == nil
        when 'sys_incs'
          merged += component.sys_incs unless component.sys_incs == nil
        when 'templates'
          merged += component.templates unless component.templates == nil
        else
          # Do nothing.
      end

      component.conditionals.each do |conditional|
        if conditional.conditions_met?(project)
          case what
            when 'defines'
              merged += conditional.defines unless conditional.defines == nil
            when 'libs'
              merged += conditional.libs unless conditional.libs == nil
            when 'srcs'
              merged += conditional.srcs unless conditional.srcs == nil
            when 'sys_srcs'
              merged += conditional.sys_srcs unless conditional.sys_srcs == nil
            when 'incs'
              merged += conditional.incs unless conditional.incs == nil
            when 'sys_incs'
              merged += conditional.sys_incs unless conditional.sys_incs == nil
            when 'templates'
              merged += conditional.templates unless conditional.templates == nil
            else
              # Do nothing.
          end
        end
      end unless component.conditionals == nil
    end
  end

  merged
end

def unpack_file(zipfile, name, dest, overwrite = false)
  if zipfile == nil || name == nil || dest == nil
    return
  end

  entries = zipfile.glob(name)

  if entries.length == 0 || entries.length > 1
    return
  end

  if File.exist?(dest) && overwrite == false
    puts "Skipping: #{dest}"
  else
    Zip::on_exists_proc = overwrite
    puts "Unpacking: #{dest}"

    FileUtils.mkdir_p(File.dirname(dest))
    entries.first.extract(dest)
    Zip::on_exists_proc = false
  end
end

def unpack_headers(zipfile, folder, dest, overwrite = false)
  if zipfile == nil || folder == nil || dest == nil
    return
  end

  entries = zipfile.glob("#{folder}/*.h")

  entries.each do |entry|
    if entry.name =~ /template.h$/
      next
    end

    filedest = entry.name.sub(folder, dest)

    unpack_file(zipfile, entry.name, filedest, overwrite)
  end
end

def unpack_cube(project, overwrite = false)
  filter = ComponentUsedFilter.new

  header_paths = []
  header_paths += merge(project.cube.components, 'incs', project, [filter])
  header_paths += merge(project.cube.components, 'sys_incs', project, [filter])
  header_paths.sort!

  file_paths = []
  file_paths += merge(project.cube.components, 'libs', project, [filter])
  file_paths += merge(project.cube.components, 'srcs', project, [filter])
  file_paths += merge(project.cube.components, 'sys_srcs', project, [filter])
  file_paths.sort!

  zipfile_name = "#{File.dirname(__FILE__)}/cubes/cube#{project.cube.name}-#{project.cube.version}.zip"

  puts "Loading cube zip: #{zipfile_name}"
  zipfile = Zip::File.open(zipfile_name)

  file_paths.each do |file|
    zipname = file.sub("cube#{project.cube.name}", project.cube.root)
    unpack_file(zipfile, zipname, file, overwrite)
  end

  header_paths.each do |header_path|
    zipname = header_path.sub("cube#{project.cube.name}", project.cube.root)
    unpack_headers(zipfile, zipname, header_path, overwrite)
  end

  zipfile.close
end

def unpack_templates(project, destdir, prompt, overwrite = false)
  filter = ComponentUsedFilter.new

  templates = []
  templates += merge(project.cube.components, 'templates', project, [filter]);
  # templates.sort! # TODO: add sorter.

  zipfile_name = "#{File.dirname(__FILE__)}/cubes/cube#{project.cube.name}-#{project.cube.version}.zip"

  puts "Loading cube zip: #{zipfile_name}"
  zipfile = Zip::File.open(zipfile_name)

  templates.each do |template|
    zipname = template.template.sub("cube#{project.cube.name}", project.cube.root)
    destname = "#{destdir}/#{File.basename(zipname)}"

    if destname =~ /_template\./
      destname.sub!(/_template\./, '.')
    end

    if prompt
      # TODO: implement prompt.
    else
      if template.auto
        unpack_file(zipfile, zipname, destname, overwrite)
      end
    end
  end

  zipfile.close
end

# unpack_cube(project, true)

unpack_templates(project, './conf', false)

puts 'Done...'