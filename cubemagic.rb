#!/usr/bin/ruby

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

$cubemagic_dir = File.dirname(__FILE__)

$:.unshift File.expand_path('./support', $cubemagic_dir)

require 'dsl.rb'
require 'project.rb'

require 'optparse'
require 'readline'
require 'zip'

# -- Main Program ------------------------------------------------------------------------------------------------------

class ComponentUsedFilter
  def filter(component, project)
    match = true
    if component == nil || project == nil || project.uses == nil || project.uses.include?(component) == false
      match = false
    end
    match
  end
end

class CmdLine
  attr_accessor :actions, :options, :project, :template_unpack_dest

  def initialize
    @actions = {}
    @options = {}
  end
end

def merge_component_base(component_base, what)
  merged = []
  case what
    when 'defines'
      merged += component_base.defines unless component_base.defines == nil
    when 'libs'
      merged += component_base.libs unless component_base.libs == nil
    when 'srcs'
      merged += component_base.srcs unless component_base.srcs == nil
    when 'sys_srcs'
      merged += component_base.sys_srcs unless component_base.sys_srcs == nil
    when 'incs'
      merged += component_base.incs unless component_base.incs == nil
    when 'sys_incs'
      merged += component_base.sys_incs unless component_base.sys_incs == nil
    when 'templates'
      merged += component_base.templates unless component_base.templates == nil
    else
      # Do nothing.
  end
  merged
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

      merged += merge_component_base(component, what)

      component.conditionals.each do |conditional|
        if conditional.conditions_met?(project)
          merged += merge_component_base(conditional, what)
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

def unpack_cube(zipfile, project, overwrite = false)
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

  file_paths.each do |file|
    zipname = file.sub("cube#{project.cube.name}", project.cube.root)
    unpack_file(zipfile, zipname, file, overwrite)
  end

  header_paths.each do |header_path|
    zipname = header_path.sub("cube#{project.cube.name}", project.cube.root)
    unpack_headers(zipfile, zipname, header_path, overwrite)
  end
end

def template_prompt(prompt)
  Readline.readline(prompt, true).squeeze(' ').strip.downcase
end

def unpack_templates(zipfile, project, destdir, prompt, overwrite = false)
  if prompt
    overwrite = true
  end

  filter = ComponentUsedFilter.new

  templates = []
  templates += merge(project.cube.components, 'templates', project, [filter])
  # templates.sort! # TODO: add sorter.

  templates.each do |template|
    zipname = template.template.sub("cube#{project.cube.name}", project.cube.root)
    destname = "#{destdir}/#{File.basename(zipname)}"

    if destname =~ /_template\./
      destname.sub!(/_template\./, '.')
    end

    if prompt
      response = template_prompt("\nUnpack template: #{template.template}\nYes or no? [no] : ")
      if response == 'yes'
        unpack_file(zipfile, zipname, destname, overwrite)
      end
    else
      if template.auto
        unpack_file(zipfile, zipname, destname, overwrite)
      end
    end
  end
end

# Variables.
cmd_line = CmdLine.new
project = nil
zipfile = nil

# Parse command line options.
OptionParser.new do |opts|
  opts.banner = 'Usage: cubemagic.rb [options]'

  opts.on('-u', '--unpack-cube', 'Unpacks the selected cube to the cubef? directory.') do |u|
    cmd_line.actions[:unpack_cube] = u
  end

  opts.on('-t', '--unpack-templates DESTINATION', 'Unpacks the templates in the cube to the specified directory.') do |ut|
    cmd_line.actions[:unpack_templates] = true
    cmd_line.template_unpack_dest = ut

  end

  opts.on('-p', '--prompt', 'Ask user input.') do |p|
    cmd_line.options[:prompt] = p
  end

  opts.on('-o', '--overwrite', 'Overwrites existing files.') do |o|
    cmd_line.options[:overwrite] = o
  end

  opts.on('-m', '--makefile', 'Generates the Makefile for the project.') do |m|
    cmd_line.actions[:makefile] = m
  end

  opts.on('-l', '--linker-script', 'Generates the linker script for the project.') do |l|
    cmd_line.actions[:linker_script] = l
  end

  opts.on('-q', '--qtcreator-project', 'Generates the Qt creator project files for the project.') do |q|
    cmd_line.actions[:qtcreator_project] = q
  end

  opts.on('-f', '--project-file PROJECT_FILE', 'Specifies the project file.') do |f|
    cmd_line.project = f
  end

  opts.on('-h', '--help', 'Displays this help text.') do
    puts opts
    exit 0
  end
end.parse!

# Further expand on the actions.
if cmd_line.actions.length > 0
  cmd_line.actions[:load_project] = true
end

if cmd_line.actions.has_key?(:unpack_cube) || cmd_line.actions.has_key?(:unpack_templates)
  cmd_line.actions[:open_zip] = true
  cmd_line.actions[:close_zip] = true
end

# Fill in the unspecified options.
unless cmd_line.options[:prompt]
  cmd_line.options[:prompt] = false
end
unless cmd_line.options[:overwrite]
  cmd_line.options[:overwrite] = false
end

# Load the project if available and needed.
if cmd_line.actions[:load_project]
  if cmd_line.project
    puts "Loading project: #{cmd_line.project}"
    project = Project.new(cmd_line.project)
  else
    puts 'WARNING: no project file specified.'
    exit 1
  end
end

# Open zip file if needed.
if cmd_line.actions[:open_zip]
  zipfile_name = "#{File.dirname(__FILE__)}/cubes/cube#{project.cube.name}-#{project.cube.version}.zip"

  puts "Loading cube zip: #{zipfile_name}"
  zipfile = Zip::File.open(zipfile_name)
end

# Unpack the cube if needed.
if cmd_line.actions[:unpack_cube]
  unpack_cube(zipfile, project, cmd_line.options[:overwrite])
end

# Unpack the templates if needed.
if cmd_line.actions[:unpack_templates]
  unpack_templates(zipfile, project, cmd_line.template_unpack_dest, cmd_line.options[:prompt], cmd_line.options[:overwrite])
end

# Close zip file if needed.
if cmd_line.actions[:close_zip]
  zipfile.close
end

# Generate the Makefile if needed.
if cmd_line.actions[:makefile]
  # TODO: implement me
end

# Generate the linker script if needed.
if cmd_line.actions[:linker_script]
  # TODO: implement me
end

# Generate the QT Creator project files if needed.
if cmd_line.actions[:qtcreator_project]
  # TODO: implement me
end

puts 'Done...'