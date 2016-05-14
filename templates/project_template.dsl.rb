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
  option 'werror'
  option 'offset', 0x0
  option 'fpu'

  oocd_path '/usr/bin'

  gcc_path '/usr/local/bin'

  oocd_cfg 'interface/stlink-v2.cfg'
  oocd_cfg 'target/stm32f4x.cfg'
end