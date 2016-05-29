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

# Descriptor file for CubeF4 V1.11.0.
cube 'f4', 'v1.11.0', 'STM32Cube_FW_F4_V1.11.0' do

  # -- Base Component Section ------------------------------------------------------------------------------------------

  # [ARM] CMSIS component as delivered by ARM.
  component 'cmsis' do
    sys_inc 'Drivers/CMSIS/Include'
  end

  # [ARM] DSP library to use DSP functions with the CM4.
  component 'dsp' do
    depends 'cmsis'
    define 'ARM_MATH_CM4'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_abs_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_abs_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_abs_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_abs_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_add_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_add_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_add_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_add_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_dot_prod_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_dot_prod_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_dot_prod_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_dot_prod_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_mult_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_mult_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_mult_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_mult_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_negate_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_negate_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_negate_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_negate_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_offset_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_offset_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_offset_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_offset_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_scale_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_scale_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_scale_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_scale_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_shift_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_shift_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_shift_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_sub_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_sub_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_sub_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/BasicMathFunctions/arm_sub_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/CommonTables/arm_common_tables.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/CommonTables/arm_const_structs.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_conj_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_conj_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_conj_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_dot_prod_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_dot_prod_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_dot_prod_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_squared_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_squared_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mag_squared_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_cmplx_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_cmplx_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_cmplx_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_real_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_real_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ComplexMathFunctions/arm_cmplx_mult_real_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_reset_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_reset_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_pid_reset_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_sin_cos_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/ControllerFunctions/arm_sin_cos_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_cos_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_cos_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_cos_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_sin_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_sin_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_sin_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_sqrt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FastMathFunctions/arm_sqrt_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_32x64_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_32x64_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df1_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df2T_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df2T_f64.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df2T_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_df2T_init_f64.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_stereo_df2T_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_biquad_cascade_stereo_df2T_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_fast_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_opt_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_fast_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_opt_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_partial_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_conv_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_fast_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_opt_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_opt_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_correlate_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_decimate_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_init_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_interpolate_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_lattice_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_init_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_fir_sparse_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_iir_lattice_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_norm_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/FilteringFunctions/arm_lms_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_add_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_add_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_add_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_cmplx_mult_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_cmplx_mult_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_cmplx_mult_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_inverse_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_inverse_f64.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_mult_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_mult_fast_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_mult_fast_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_mult_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_mult_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_scale_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_scale_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_scale_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_sub_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_sub_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_sub_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_trans_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_trans_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/MatrixFunctions/arm_mat_trans_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_max_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_max_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_max_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_max_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_mean_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_mean_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_mean_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_mean_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_min_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_min_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_min_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_min_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_power_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_power_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_power_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_power_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_rms_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_rms_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_rms_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_std_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_std_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_std_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_var_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_var_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/StatisticsFunctions/arm_var_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_copy_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_copy_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_copy_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_copy_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_fill_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_fill_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_fill_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_fill_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_float_to_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_float_to_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_float_to_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q15_to_float.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q15_to_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q15_to_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q31_to_float.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q31_to_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q31_to_q7.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q7_to_float.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q7_to_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/SupportFunctions/arm_q7_to_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_bitreversal.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_bitreversal2.S'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix2_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix4_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_cfft_radix8_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_dct4_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_fast_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_fast_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_init_f32.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_init_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_init_q31.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_q15.c'
    sys_src 'Drivers/CMSIS/DSP_Lib/Source/TransformFunctions/arm_rfft_q31.c'
  end

  # [ST] HAL library component.
  component 'hal' do
    depends 'cmsis'
    define 'USE_HAL_DRIVER'
    sys_inc 'Drivers/STM32F4xx_HAL_Driver/Inc'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_adc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_adc_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_can.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cec.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_crc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cryp.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cryp_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dac.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dac_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dcmi.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dcmi_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma2d.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dsi.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_eth.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_fmpi2c.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_fmpi2c_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hash.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hash_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_hcd.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2c_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2s.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_i2s_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_irda.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_iwdg.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_lptim.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_ltdc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_ltdc_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nand.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nor.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pccard.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pcd_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_qspi.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rng.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rtc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rtc_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sai.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sai_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sd.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sdram.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_smartcard.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_spdifrx.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_spi.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sram.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_uart.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_usart.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_wwdg.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fmc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fsmc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_sdmmc.c'
    sys_src 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_usb.c'
    template 'Drivers/STM32F4xx_HAL_Driver/Inc/stm32f4xx_hal_conf_template.h', 'auto'
    template 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_msp_template.c'
    template 'Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_timebase_tim_template.c'
  end

  # -- Chip Support Section --------------------------------------------------------------------------------------------

  # [ST] Common declarations for chip family.
  chipfamily 'stm32f4xx' do
    depends 'cmsis'
    flash_base 0x08000000
    sram_base 0x20000000
    ccm_base 0x10000000
    arch 'cpu=cortex-m4'
    arch 'thumb'
    conditional do
      condition_option_set 'fpu'
      define '__FPU_PRESENT', 1
      arch 'float-abi=hard'
      arch 'fpu=fpv4-sp-d16'
    end
    sys_inc 'Drivers/CMSIS/Device/ST/STM32F4xx/Include'
    template 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c', 'auto'
  end

  # [ST] 401xB chip.
  chip 'stm32f401xb' do
    depends 'stm32f4xx'
    flash '128k'
    sram '64k'
    define 'STM32F401xC'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xc.s'
  end

  # [ST] 401xC chip.
  chip 'stm32f401xc' do
    depends 'stm32f4xx'
    flash '256k'
    sram '64k'
    define 'STM32F401xC'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xc.s'
  end

  # [ST] 401xD chip.
  chip 'stm32f401xd' do
    depends 'stm32f4xx'
    flash '384k'
    sram '96k'
    define 'STM32F401xE'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xe.s'
  end

  # [ST] 401xE chip.
  chip 'stm32f401xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '96k'
    define 'STM32F401xE'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f401xe.s'
  end

  # [ST] 405xE chip.
  chip 'stm32f405xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '128k'
    ccm '64k'
    define 'STM32F405xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f405xx.s'
  end

  # [ST] 405xG chip.
  chip 'stm32f405xg' do
    depends 'stm32f4xx'
    flash '1024k'
    sram '128k'
    ccm '64k'
    define 'STM32F405xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f405xx.s'
  end

  # [ST] 407xE chip.
  chip 'stm32f407xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '128k'
    ccm '64k'
    define 'STM32F407xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f407xx.s'
  end

  # [ST] 407xG chip.
  chip 'stm32f407xg' do
    depends 'stm32f4xx'
    flash '1M'
    sram '128k'
    ccm '64k'
    define 'STM32F407xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f407xx.s'
  end

  # [ST] 417xE chip.
  chip 'stm32f417xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '128k'
    ccm '64k'
    define 'STM32F417xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f417xx.s'
  end

  # [ST] 417xE chip.
  chip 'stm32f417xg' do
    depends 'stm32f4xx'
    flash '1M'
    sram '128k'
    ccm '64k'
    define 'STM32F417xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f417xx.s'
  end

  # [ST] 429xE chip.
  chip 'stm32f429xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '192k'
    ccm '64k'
    define 'STM32F429xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f429xx.s'
  end

  # [ST] 429xG chip.
  chip 'stm32f429xg' do
    depends 'stm32f4xx'
    flash '1M'
    sram '192k'
    ccm '64k'
    define 'STM32F429xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f429xx.s'
  end

  # [ST] 429xI chip.
  chip 'stm32f429xi' do
    depends 'stm32f4xx'
    flash '2M'
    sram '192k'
    ccm '64k'
    define 'STM32F429xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f429xx.s'
  end

  # [ST] 439xE chip.
  chip 'stm32f439xe' do
    depends 'stm32f4xx'
    flash '512k'
    sram '192k'
    ccm '64k'
    define 'STM32F439xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f439xx.s'
  end

  # [ST] 439xG chip.
  chip 'stm32f439xg' do
    depends 'stm32f4xx'
    flash '1M'
    sram '192k'
    ccm '64k'
    define 'STM32F439xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f439xx.s'
  end

  # [ST] 439xI chip.
  chip 'stm32f439xi' do
    depends 'stm32f4xx'
    flash '2M'
    sram '192k'
    ccm '64k'
    define 'STM32F439xx'
    sys_src 'Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/startup_stm32f439xx.s'
  end

  # -- Board Support Section -------------------------------------------------------------------------------------------

  # [ST] Common component for board support packages.
  component 'bsp_common' do
    sys_inc 'Drivers/BSP/Components/Common'
  end

  # [ST] Component driver for cs43l22 chip.
  component 'cs43l22' do
    sys_inc 'Drivers/BSP/Components/cs43l22'
    sys_src 'Drivers/BSP/Components/cs43l22/cs43l22.c'
  end

  # [ST] Component driver for ili9341 chip.
  component 'ili9341' do
    sys_inc 'Drivers/BSP/Components/ili9341'
    sys_src 'Drivers/BSP/Components/ili9341/ili9341.c'
  end

  # [ST] Component driver for l3gd20 chip.
  component 'l3gd20' do
    sys_inc 'Drivers/BSP/Components/l3gd20'
    sys_src 'Drivers/BSP/Components/l3gd20/l3gd20.c'
  end

  # [ST] Component driver for lis302dl chip.
  component 'lis302dl' do
    sys_inc 'Drivers/BSP/Components/lis302dl'
    sys_src 'Drivers/BSP/Components/lis302dl/lis302dl.c'
  end

  # [ST] Component driver for lis3dsh chip.
  component 'lis3dsh' do
    sys_inc 'Drivers/BSP/Components/lis3dsh'
    sys_src 'Drivers/BSP/Components/lis3dsh/lis3dsh.c'
  end

  # [ST] Component driver for stmpe811 chip.
  component 'stmpe811' do
    sys_inc 'Drivers/BSP/Components/stmpe811'
    sys_src 'Drivers/BSP/Components/stmpe811/stmpe811.c'
  end

  # [ST] Board support package for STM32F4-Discovery board.
  board 'stm32f4-discovery' do
    define 'HSE_VALUE', '8000000'
    depends 'stm32f407xg'
    depends 'hal'
    depends 'bsp_common'
    depends 'cs43l22'
    depends 'lis302dl'
    depends 'lis3dsh'
    depends 'stm32_audio'
    sys_inc 'Drivers/BSP/STM32F4-Discovery'
    sys_src 'Drivers/BSP/STM32F4-Discovery/stm32f4_discovery.c'
    sys_src 'Drivers/BSP/STM32F4-Discovery/stm32f4_discovery_accelerometer.c'
    sys_src 'Drivers/BSP/STM32F4-Discovery/stm32f4_discovery_audio.c'
  end

  # [ST] Board support package for STM32F429I-Discovery board.
  board 'stm32f429i-discovery' do
    define 'HSE_VALUE', '8000000'
    depends 'stm32f429xi'
    depends 'hal'
    depends 'bsp_common'
    depends 'fonts'
    depends 'ili9341'
    depends 'l3gd20'
    depends 'stmpe811'
    sys_inc 'Drivers/BSP/STM32F429I-Discovery'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_eeprom.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_gyroscope.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_io.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_lcd.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_sdram.c'
    sys_src 'Drivers/BSP/STM32F429I-Discovery/stm32f429i_discovery_ts.c'
  end

  # [ST] Board support package for STM32F4xx-Nucleo board.
  board 'stm32f4xx-nucleo' do
    depends 'stm32f401xe'
    depends 'hal'
    sys_inc 'Drivers/BSP/STM32F4xx-Nucleo'
    sys_src 'Drivers/BSP/STM32F4xx-Nucleo/stm32f4xx_nucleo.c'
  end

  # -- Middleware Support Section --------------------------------------------------------------------------------------

  # [ST] PDM Filter audio addon.
  component 'stm32_audio' do
    sys_inc 'Middlewares/ST/STM32_Audio/Addons/PDM'
    conditional do
      condition_option_set 'fpu'
      lib 'Middlewares/ST/STM32_Audio/Addons/PDM/libPDMFilter_CM4F_GCC.a'
    end
    conditional do
      condition_option_unset 'fpu'
      lib 'Middlewares/ST/STM32_Audio/Addons/PDM/libPDMFilter_CM4_GCC.a'
    end
  end

  # [CHaN] FAT File System.
  component 'fatfs' do
    sys_inc 'Middlewares/Third_Party/FatFs/src'
    sys_src 'Middlewares/Third_Party/FatFs/src/diskio.c'
    sys_src 'Middlewares/Third_Party/FatFs/src/ff.c'
    sys_src 'Middlewares/Third_Party/FatFs/src/ff_gen_drv.c' # [ST]
    conditional do
      condition_used 'freertos'
      sys_src 'Middlewares/Third_Party/FatFs/src/option/syscall.c'
    end
    sys_src 'Middlewares/Third_Party/FatFs/src/option/unicode.c'
    file 'Middlewares/Third_Party/FatFs/src/option/cc932.c'
    file 'Middlewares/Third_Party/FatFs/src/option/cc936.c'
    file 'Middlewares/Third_Party/FatFs/src/option/cc949.c'
    file 'Middlewares/Third_Party/FatFs/src/option/cc950.c'
    file 'Middlewares/Third_Party/FatFs/src/option/ccsbcs.c'
    template 'Middlewares/Third_Party/FatFs/src/ffconf_template.h'
  end

  # [ST] SD FAT File System driver.
  component 'fatfs_sd' do
    depends 'fatfs'
    sys_inc 'Middlewares/Third_Party/FatFs/src/drivers'
    sys_src 'Middlewares/Third_Party/FatFs/src/drivers/sd_diskio.c'
  end

  # [ST] SDRAM FAT File System driver.
  component 'fatfs_sdram' do
    depends 'fatfs'
    sys_inc 'Middlewares/Third_Party/FatFs/src/drivers'
    sys_src 'Middlewares/Third_Party/FatFs/src/drivers/sdram_diskio.c'
  end

  # [ST] SRAM FAT File System driver.
  component 'fatfs_sram' do
    depends 'fatfs'
    sys_inc 'Middlewares/Third_Party/FatFs/src/drivers'
    sys_src 'Middlewares/Third_Party/FatFs/src/drivers/sram_diskio.c'
  end

  # [ST] USB-H FAT File System driver.
  component 'fatfs_usbh' do
    depends 'fatfs'
    sys_inc 'Middlewares/Third_Party/FatFs/src/drivers'
    sys_src 'Middlewares/Third_Party/FatFs/src/drivers/usbh_diskio.c'
  end

  # -- Utilities Support Section ---------------------------------------------------------------------------------------

  # [ST] Fonts utility support.
  component 'fonts' do
    sys_inc 'Utilities/Fonts'
    file 'Utilities/Fonts/font8.c'
    file 'Utilities/Fonts/font12.c'
    file 'Utilities/Fonts/font16.c'
    file 'Utilities/Fonts/font20.c'
    file 'Utilities/Fonts/font24.c'
  end

  # [ST] Log utility support.
  component 'lcd_log' do
    sys_inc 'Utilities/Log'
    sys_src 'Utilities/Log/lcd_log.c'
    template 'Utilities/Log/lcd_log_conf_template.h'
  end
end