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

require 'optparse'
require 'readline'
require 'pathname'
require 'zip'

if File.symlink?(__FILE__)
  $cubemagic_dir = File.dirname(Pathname.new(__FILE__).realpath)
else
  $cubemagic_dir = File.dirname(__FILE__)
end

$:.unshift File.expand_path('./support', $cubemagic_dir)

require 'dsl.rb'
require 'project.rb'
require 'utils.rb'

# -- Main Program ------------------------------------------------------------------------------------------------------

class CmdLine
  attr_accessor :actions, :options, :project, :template_unpack_dest

  def initialize
    @actions = {}
    @options = {}
  end
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

  entries = zipfile.glob("#{folder}/**/*.h")

  entries.each do |entry|
    if entry.name =~ /template.h$/
      next
    end

    filedest = entry.name.sub(folder, dest)

    unpack_file(zipfile, entry.name, filedest, overwrite)
  end
end

def unpack_cube(zipfile, project, overwrite = false)
  used_filter = ComponentUsedFilter.new
  cube_filter = ComponentCubeFilter.new

  header_paths = []
  header_paths += project.merge('incs', [used_filter, cube_filter])
  header_paths += project.merge('sys_incs', [used_filter, cube_filter])
  header_paths.sort!

  file_paths = []
  file_paths += project.merge('libs', [used_filter, cube_filter])
  file_paths += project.merge('srcs', [used_filter, cube_filter])
  file_paths += project.merge('sys_srcs', [used_filter, cube_filter])
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

  used_filter = ComponentUsedFilter.new
  cube_filter = ComponentCubeFilter.new

  templates = []
  templates += project.merge('templates', [used_filter, cube_filter])
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
  zipfile_name = "#{$cubemagic_dir}/cubes/cube#{project.cube.name}-#{project.cube.version}.zip"

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
  puts 'Generating Makefile: Makefile'
  MakefileGen.new(project.fetch_makefile_data).generate
end

# Generate the linker script if needed.
if cmd_line.actions[:linker_script]
  puts 'Generating linker script: ldscript.ld'
  LdScriptGen.new(project.fetch_linker_script_data).generate
end

# Generate the QT Creator project files if needed.
if cmd_line.actions[:qtcreator_project]
  # TODO: implement me
end

puts 'Done...'