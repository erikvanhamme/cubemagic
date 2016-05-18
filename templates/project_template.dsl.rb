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

project 'template_project' do

  cube 'f4', 'v1.11.0'

  mode 'debug'

  src_dir 'src'
  src_dir 'hw'

  use 'stm32f4-discovery'
  use 'dsp'

  define 'HELLOWORLD', 1

  option 'noexcept'
  option 'nortti'
  option 'c++14'
  option 'c11'
  option 'werror'
  option 'offset', 0x0
  option 'fpu'

  oocd_path '/usr/bin'

  gcc_path '/usr/local/bin'

  oocd_cfg 'interface/stlink-v2.cfg'
  oocd_cfg 'target/stm32f4x.cfg'
end