# Begin generated code

.namespace [ ]

.sub 'main' :main
.param pmc argv
set $P1, argv

.annotate 'file', '../libjit_fb/setup.winxed'
.annotate 'line', 23
# Body
# {
.annotate 'line', 24
load_bytecode 'distutils.pbc'
.annotate 'line', 25
get_hll_global $P3, 'template_fill'
.annotate 'line', 26
get_hll_global $P4, 'template_clean'
.annotate 'line', 29
$P5 = $P1.'shift'()
.annotate 'line', 31
$P5 = 'register_step_before'('build', $P3)
.annotate 'line', 32
$P6 = 'register_step_after'('clean', $P4)
.annotate 'line', 34
# var conf: $P2
$P2 = 'load_setup_json'()
.annotate 'line', 35
$P6 = 'gen_tmpl_data'($P2)
$P2['template_data'] = $P6
.annotate 'line', 37
$P7 = 'setup'($P1 :flat, $P2 :flat :named)
# }
.annotate 'line', 38

.end # main


.sub 'template_fill'
.param pmc kv :named :slurpy
set $P1, kv

.annotate 'line', 59
# Body
# {
.annotate 'line', 60
# var templates: $P2
$P4 = $P1['template']
if_null $P4, __label_1
unless $P4 goto __label_1
$P2 = $P1['template']
goto __label_0
__label_1:
root_new $P2, ['parrot';'Hash']
__label_0:
.annotate 'line', 61
# var template_data: $P3
$P4 = $P1['template_data']
if_null $P4, __label_3
unless $P4 goto __label_3
$P3 = $P1['template_data']
goto __label_2
__label_3:
root_new $P5, ['parrot';'ResizablePMCArray']
set $P3, $P5
__label_2:
.annotate 'line', 63
iter $P7, $P2
set $P7, 0
__label_4: # for iteration
unless $P7 goto __label_5
shift $S1, $P7
# {
.annotate 'line', 64
# string targ_file: $S2
$S2 = $P2[$S1]
.annotate 'line', 65
$P5 = 'do_subst'($P3, $S1, $S2)
# }
goto __label_4
__label_5: # endfor
# }
.annotate 'line', 67

.end # template_fill


.sub 'do_subst'
.param pmc subst_data
.param string in_file
.param string out_file
set $P1, subst_data
set $S1, in_file
set $S2, out_file

.annotate 'line', 69
# Body
# {
# predefined say
.annotate 'line', 70
say $S1
# predefined say
.annotate 'line', 71
say $S2
.annotate 'line', 72
# var in_fh: $P2
# predefined open
root_new $P2, ['parrot';'FileHandle']
$P2.'open'($S1,'ro')
.annotate 'line', 73
# var out_fh: $P3
# predefined open
root_new $P3, ['parrot';'FileHandle']
$P3.'open'($S2,'rw')
__label_1: # while
.annotate 'line', 75
if_null $P2, __label_0
unless $P2 goto __label_0
# {
.annotate 'line', 76
# var line: $P4
$P4 = $P2.'readline'()
.annotate 'line', 78
iter $P6, $P1
set $P6, 0
__label_2: # for iteration
unless $P6 goto __label_3
shift $S3, $P6
# {
.annotate 'line', 79
# string search: $S4
concat $S5, "@", $S3
concat $S4, $S5, "@"
$P8 = $P1[$S3]
.annotate 'line', 80
$P7 = $P4.'replace'($S4, $P8)
# }
goto __label_2
__label_3: # endfor
.annotate 'line', 83
$P7 = $P3.'puts'($P4)
# }
goto __label_1
__label_0: # endwhile
.annotate 'line', 86
$P8 = $P2.'close'()
.annotate 'line', 87
$P9 = $P3.'close'()
# }
.annotate 'line', 88

.end # do_subst


.sub 'template_clean'
.param pmc kv :named :slurpy
set $P1, kv

.annotate 'line', 90
# Body
# {
.annotate 'line', 91
# var templates: $P2
$P3 = $P1['template']
if_null $P3, __label_1
unless $P3 goto __label_1
$P2 = $P1['template']
goto __label_0
__label_1:
root_new $P2, ['parrot';'Hash']
__label_0:
.annotate 'line', 93
iter $P4, $P2
set $P4, 0
__label_2: # for iteration
unless $P4 goto __label_3
shift $S1, $P4
# {
.annotate 'line', 94
# string targ_file: $S2
$S2 = $P2[$S1]
.annotate 'line', 95
$P3 = 'unlink'($S2, 1 :named('verbose'))
# }
goto __label_2
__label_3: # endfor
# }
.annotate 'line', 97

.end # template_clean


.sub 'load_setup_json'

.annotate 'line', 109
# Body
# {
.annotate 'line', 110
# var file: $P1
# predefined open
root_new $P1, ['parrot';'FileHandle']
$P1.'open'('setup.json')
.annotate 'line', 111
# string json_str: $S1
$P4 = $P1.'readall'()
null $S1
if_null $P4, __label_0
set $S1, $P4
__label_0:
.annotate 'line', 112
$P4 = $P1.'close'()
.annotate 'line', 113
# var json: $P2
# predefined load_language
load_language 'data_json'
compreg $P2, 'data_json'
.annotate 'line', 114
# var promise: $P3
$P3 = $P2.'compile'($S1)
.annotate 'line', 115
$P5 = $P3()
.return($P5)
# }
.annotate 'line', 116

.end # load_setup_json


.sub 'gen_tmpl_data'
.param pmc conf
set $P1, conf

.annotate 'line', 128
# Body
# {
.annotate 'line', 129
# var vtable_wrappers: $P2
$P4 = $P1['wrapped_vtables']
$P2 = 'gen_vtable_wrappers'($P4)
.annotate 'line', 130
# var function_wrappers: $P3
$P4 = $P1['wrapped_functions']
$P3 = 'gen_function_wrappers'($P4)
.annotate 'line', 131
root_new $P5, ['parrot';'Hash']
.annotate 'line', 132
$P6 = 'pick_iv'()
$P5['libjit_iv'] = $P6
.annotate 'line', 133
$P7 = 'pick_uv'()
$P5['libjit_uv'] = $P7
.annotate 'line', 134
$P8 = 'pick_nv'()
$P5['libjit_nv'] = $P8
$P5['libjit_has_alloca'] = 0
.annotate 'line', 136
$P9 = 'decls'($P2)
# predefined join
join $S1, "\n", $P9
$P5['vtable_wrap_decls'] = $S1
.annotate 'line', 137
$P10 = 'defns'($P2)
# predefined join
join $S2, "\n", $P10
$P5['vtable_wrap_defns'] = $S2
.annotate 'line', 138
$P11 = 'decls'($P3)
# predefined join
join $S3, "\n", $P11
$P5['func_wrap_decls'] = $S3
.annotate 'line', 139
$P12 = 'defns'($P3)
# predefined join
join $S4, "\n", $P12
$P5['func_wrap_defns'] = $S4
.annotate 'line', 131
.return($P5)
# }
.annotate 'line', 141

.end # gen_tmpl_data


.sub 'pick_iv'

.annotate 'line', 161
# Body
# {
.annotate 'line', 162
get_hll_global $P2, 'get_config'
.annotate 'line', 163
# var parrot_config: $P1
$P1 = $P2()
.annotate 'line', 164
# string iv: $S1
$S1 = $P1['iv']
set $S2, $S1
set $S3, 'short'
.annotate 'line', 165
if $S2 == $S3 goto __label_2
set $S3, 'int'
if $S2 == $S3 goto __label_3
set $S3, 'long'
if $S2 == $S3 goto __label_4
set $S3, 'long long'
if $S2 == $S3 goto __label_5
goto __label_1
# switch
__label_2: # case
.annotate 'line', 167
.return('jit_type_sys_short')
__label_3: # case
.annotate 'line', 169
.return('jit_type_sys_int')
__label_4: # case
.annotate 'line', 171
.return('jit_type_sys_long')
__label_5: # case
.annotate 'line', 173
.return('jit_type_sys_longlong')
__label_1: # default
.annotate 'line', 175
root_new $P4, ['parrot';'Hash']
.annotate 'line', 176
root_new $P6, ['parrot';'ResizablePMCArray']
box $P7, $S1
$P6.'push'($P7)
$P5 = 'sprintf'("Couldn't determine a libjity type for intval of type '%s'", $P6)
$P4['message'] = $P5
root_new $P3, ['parrot'; 'Exception' ], $P4
.annotate 'line', 175
throw $P3
__label_0: # switch end
# }
.annotate 'line', 179

.end # pick_iv


.sub 'pick_uv'

.annotate 'line', 181
# Body
# {
.annotate 'line', 182
get_hll_global $P2, 'get_config'
.annotate 'line', 183
# var parrot_config: $P1
$P1 = $P2()
.annotate 'line', 184
# string iv: $S1
$S1 = $P1['iv']
set $S2, $S1
set $S3, 'short'
.annotate 'line', 185
if $S2 == $S3 goto __label_2
set $S3, 'int'
if $S2 == $S3 goto __label_3
set $S3, 'long'
if $S2 == $S3 goto __label_4
set $S3, 'long long'
if $S2 == $S3 goto __label_5
goto __label_1
# switch
__label_2: # case
.annotate 'line', 187
.return('jit_type_sys_ushort')
__label_3: # case
.annotate 'line', 189
.return('jit_type_sys_uint')
__label_4: # case
.annotate 'line', 191
.return('jit_type_sys_ulong')
__label_5: # case
.annotate 'line', 193
.return('jit_type_sys_ulonglong')
__label_1: # default
.annotate 'line', 195
root_new $P4, ['parrot';'Hash']
.annotate 'line', 197
root_new $P6, ['parrot';'ResizablePMCArray']
box $P7, $S1
$P6.'push'($P7)
$P5 = 'sprintf'("Couldn't determine a libjity type for uintval of type 'unsigned %s'", $P6)
$P4['message'] = $P5
root_new $P3, ['parrot'; 'Exception' ], $P4
.annotate 'line', 195
throw $P3
__label_0: # switch end
# }
.annotate 'line', 200

.end # pick_uv


.sub 'pick_nv'

.annotate 'line', 202
# Body
# {
.annotate 'line', 203
get_hll_global $P2, 'get_config'
.annotate 'line', 204
# var parrot_config: $P1
$P1 = $P2()
.annotate 'line', 205
# string nv: $S1
$S1 = $P1['nv']
set $S2, $S1
set $S3, 'float'
.annotate 'line', 206
if $S2 == $S3 goto __label_2
set $S3, 'double'
if $S2 == $S3 goto __label_3
set $S3, 'long double'
if $S2 == $S3 goto __label_4
goto __label_1
# switch
__label_2: # case
.annotate 'line', 208
.return('jit_type_sys_float')
__label_3: # case
.annotate 'line', 210
.return('jit_type_sys_double')
__label_4: # case
.annotate 'line', 212
.return('jit_type_sys_long_double')
__label_1: # default
.annotate 'line', 214
root_new $P4, ['parrot';'Hash']
.annotate 'line', 215
root_new $P6, ['parrot';'ResizablePMCArray']
box $P7, $S1
$P6.'push'($P7)
$P5 = 'sprintf'("Couldn't determine a libjity type for floatval of type '%s'", $P6)
$P4['message'] = $P5
root_new $P3, ['parrot'; 'Exception' ], $P4
.annotate 'line', 214
throw $P3
__label_0: # switch end
# }
.annotate 'line', 218

.end # pick_nv


.sub 'decls'
.param pmc wrappers
set $P1, wrappers

.annotate 'line', 234
# Body
# {
.annotate 'line', 235
# var retv: $P2
root_new $P4, ['parrot';'ResizablePMCArray']
set $P2, $P4
.annotate 'line', 236
iter $P6, $P1
set $P6, 0
__label_0: # for iteration
unless $P6 goto __label_1
shift $P3, $P6
$P5 = $P3['decl']
.annotate 'line', 237
$P4 = $P2.'push'($P5)
goto __label_0
__label_1: # endfor
.annotate 'line', 238
.return($P2)
# }
.annotate 'line', 239

.end # decls


.sub 'defns'
.param pmc wrappers
set $P1, wrappers

.annotate 'line', 241
# Body
# {
.annotate 'line', 242
# var retv: $P2
root_new $P4, ['parrot';'ResizablePMCArray']
set $P2, $P4
.annotate 'line', 243
iter $P6, $P1
set $P6, 0
__label_0: # for iteration
unless $P6 goto __label_1
shift $P3, $P6
$P5 = $P3['defn']
.annotate 'line', 244
$P4 = $P2.'push'($P5)
goto __label_0
__label_1: # endfor
.annotate 'line', 245
.return($P2)
# }
.annotate 'line', 246

.end # defns


.sub 'jit_prefix_type'
.param string type
set $S1, type

.annotate 'line', 258
# Body
# {
.annotate 'line', 259
# predefined downcase
downcase $S2, $S1
iseq $I1, $S1, $S2
unless $I1 goto __label_0
concat $S3, 'jit_type_', $S1
.annotate 'line', 260
.return($S3)
goto __label_1
__label_0: # else
.annotate 'line', 261
# predefined upcase
upcase $S4, $S1
iseq $I2, $S1, $S4
unless $I2 goto __label_2
concat $S5, 'JIT_TYPE_', $S1
.annotate 'line', 262
.return($S5)
goto __label_3
__label_2: # else
.annotate 'line', 264
root_new $P2, ['parrot';'Hash']
$P2["message"] = "can't jit_prefix_type: inconsistent case"
root_new $P1, ['parrot'; 'Exception' ], $P2
throw $P1
__label_3: # endif
__label_1: # endif
# }
.annotate 'line', 265

.end # jit_prefix_type


.sub 'gen_vtable_wrappers'
.param pmc vtables
set $P1, vtables

.annotate 'line', 279
# Body
# {
# Constant vtable_decl_tmpl evaluted at compile time
# Constant vtable_defn_tmpl evaluted at compile time
.annotate 'line', 298
# var wrappers: $P2
root_new $P5, ['parrot';'ResizablePMCArray']
set $P2, $P5
.annotate 'line', 300
iter $P7, $P1
set $P7, 0
__label_0: # for iteration
unless $P7 goto __label_1
shift $S1, $P7
# {
.annotate 'line', 301
# var entry_sig: $P3
$P3 = $P1[$S1]
.annotate 'line', 303
# int n_args: $I1
$I1 = $P3[0]
.annotate 'line', 305
# var acc: $P4
root_new $P5, ['parrot';'ResizablePMCArray']
set $P4, $P5
# for loop
.annotate 'line', 306
# int i: $I2
null $I2
goto __label_4
__label_2: # for iteration
set $I6, $I2
inc $I2
__label_4: # for condition
islt $I7, $I2, $I1
unless $I7 goto __label_3 # for end
.annotate 'line', 307
root_new $P8, ['parrot';'ResizablePMCArray']
$P11 = $P3[0; $I2]
$P10 = 'jit_prefix_type'($P11)
$P8.'push'($P10)
# predefined sprintf
sprintf $S7, ', %s', $P8
$P4[$I2] = $S7
goto __label_2 # for iteration
__label_3: # for end
.annotate 'line', 308
# string arg_t: $S2
# predefined join
join $S2, '', $P4
.annotate 'line', 310
# string ret_t: $S3
$P9 = $P3[1]
$P8 = 'jit_prefix_type'($P9)
null $S3
if_null $P8, __label_5
set $S3, $P8
__label_5:
.annotate 'line', 312
root_new $P10, ['parrot';'ResizablePMCArray']
set $P4, $P10
# for loop
.annotate 'line', 313
# int i: $I3
null $I3
goto __label_8
__label_6: # for iteration
set $I6, $I3
inc $I3
__label_8: # for condition
islt $I7, $I3, $I1
unless $I7 goto __label_7 # for end
.annotate 'line', 314
root_new $P13, ['parrot';'ResizablePMCArray']
box $P14, $I3
$P13.'push'($P14)
# predefined sprintf
sprintf $S7, ', v%d', $P13
$P12 = $P4.'push'($S7)
goto __label_6 # for iteration
__label_7: # for end
.annotate 'line', 315
# string arg_v: $S4
# predefined join
join $S4, '', $P4
.annotate 'line', 317
root_new $P12, ['parrot';'ResizablePMCArray']
set $P4, $P12
# for loop
.annotate 'line', 318
# int i: $I4
null $I4
goto __label_11
__label_9: # for iteration
set $I8, $I4
inc $I4
__label_11: # for condition
islt $I9, $I4, $I1
unless $I9 goto __label_10 # for end
.annotate 'line', 319
$P14 = $P4.'push'(', jit_value_t')
goto __label_9 # for iteration
__label_10: # for end
.annotate 'line', 320
# string arg_decls_t: $S5
# predefined join
join $S5, '', $P4
.annotate 'line', 322
root_new $P15, ['parrot';'ResizablePMCArray']
set $P4, $P15
# for loop
.annotate 'line', 323
# int i: $I5
null $I5
goto __label_14
__label_12: # for iteration
set $I8, $I5
inc $I5
__label_14: # for condition
islt $I9, $I5, $I1
unless $I9 goto __label_13 # for end
.annotate 'line', 324
root_new $P16, ['parrot';'ResizablePMCArray']
box $P17, $I5
$P16.'push'($P17)
# predefined sprintf
sprintf $S8, ', jit_value_t v%d', $P16
$P15 = $P4.'push'($S8)
goto __label_12 # for iteration
__label_13: # for end
.annotate 'line', 325
# string arg_decls_v: $S6
# predefined join
join $S6, '', $P4
.annotate 'line', 327
root_new $P18, ['parrot';'Hash']
.annotate 'line', 328
root_new $P19, ['parrot';'ResizablePMCArray']
box $P20, $S1
$P19.'push'($P20)
box $P20, $S5
$P19.'push'($P20)
# predefined sprintf
sprintf $S8, "static jit_value_t\njit__vtable_%s(jit_function_t, jit_value_t, jit_value_t %s);", $P19
$P18['decl'] = $S8
.annotate 'line', 330
root_new $P21, ['parrot';'ResizablePMCArray']
box $P22, $S1
$P21.'push'($P22)
box $P22, $S6
$P21.'push'($P22)
box $P22, $I1
$P21.'push'($P22)
box $P22, $S2
$P21.'push'($P22)
box $P22, $S4
$P21.'push'($P22)
box $P22, $S3
$P21.'push'($P22)
box $P22, $S1
$P21.'push'($P22)
# predefined sprintf
.annotate 'line', 329
sprintf $S9, "static jit_value_t\njit__vtable_%s(jit_function_t f, jit_value_t interp, jit_value_t self %s) {   const int n_args = %d + 2;\n   jit_type_t sig;\n   jit_value_t vtable, method;\n   jit_type_t  arg_t[] = { jit_type_void_ptr, jit_type_void_ptr %s };\n   jit_value_t arg_v[] = { interp, self %s };\n   sig = jit_type_create_signature(jit_abi_cdecl, %s, arg_t, n_args, 1);\n   vtable = jit_insn_load_relative(f, self, offsetof(PMC, vtable), jit_type_void_ptr);\n   method = jit_insn_load_relative(f, vtable, offsetof(VTABLE, %s), jit_type_void_ptr);\n   return jit_insn_call_indirect(f, method, sig, arg_v, n_args, 0);\n}", $P21
$P18['defn'] = $S9
.annotate 'line', 327
$P17 = $P2.'push'($P18)
# }
goto __label_0
__label_1: # endfor
.annotate 'line', 334
.return($P2)
# }
.annotate 'line', 335

.end # gen_vtable_wrappers


.sub 'gen_function_wrappers'
.param pmc funcs
set $P1, funcs

.annotate 'line', 337
# Body
# {
.annotate 'line', 338
# var wrappers: $P2
root_new $P6, ['parrot';'ResizablePMCArray']
set $P2, $P6
.annotate 'line', 340
iter $P8, $P1
set $P8, 0
__label_0: # for iteration
unless $P8 goto __label_1
shift $S1, $P8
# {
.annotate 'line', 341
# var entry_sig: $P3
$P3 = $P1[$S1]
.annotate 'line', 343
# var args_sig: $P4
$P4 = $P3[0]
.annotate 'line', 344
# int n_args: $I1
# predefined elements
elements $I1, $P4
.annotate 'line', 346
# string func_decl_tmpl: $S2
null $S2
.annotate 'line', 347
# string func_defn_tmpl: $S3
null $S3
set $I6, $I1
.annotate 'line', 348
unless $I6 goto __label_4
sub $I7, $I1, 1
$P6 = $P4[$I7]
$S9 = $P6
iseq $I6, $S9, '...'
__label_4:
unless $I6 goto __label_2
# {
.annotate 'line', 349
$P7 = $P4.'pop'()
set $I6, $I1
.annotate 'line', 350
dec $I1
set $S2, "static jit_value_t\njit__%s(jit_function_t %s, jit_type_t *, jit_value_t *, int);\n"
set $S3, "static jit_value_t\njit__%s(jit_function_t f %s, jit_type_t *va_t, jit_value_t *va_v, const int va_n) {\n   int i;\n   const int n_args = %d;\n   jit_type_t sig;\n   jit_value_t vtable;\n   jit_type_t  arg_t[n_args + va_n];\n   jit_value_t arg_v[n_args + va_n];\n   jit_type_t  carg_t[] = { %s };\n   jit_value_t carg_v[] = { %s };\n   for (i = 0; i < n_args; i++) {\n       arg_t[i] = carg_t[i];\n       arg_v[i] = carg_v[i];\n   }\n   for (i = 0; i < va_n; i++) {\n       arg_t[n_args + i] = va_t[i];\n       arg_v[n_args + i] = va_v[i];\n   }\n   sig = jit_type_create_signature(jit_abi_cdecl, %s, arg_t, n_args + va_n, 1);\n   return jit_insn_call_native(f, \"%s\", (void *)&%s, sig, arg_v, n_args + va_n, 0);\n}\n"
.annotate 'line', 355
# }
goto __label_3
__label_2: # else
# {
set $S2, "static jit_value_t\njit__%s(jit_function_t %s);\n"
set $S3, "static jit_value_t\njit__%s(jit_function_t f %s) {\n   const int n_args = %d;\n   jit_type_t sig;\n   jit_value_t vtable;\n   jit_type_t  arg_t[] = { %s };\n   jit_value_t arg_v[] = { %s };\n   sig = jit_type_create_signature(jit_abi_cdecl, %s, arg_t, n_args, 1);\n   return jit_insn_call_native(f, \"%s\", (void *)&%s, sig, arg_v, n_args, 0);\n}\n"
.annotate 'line', 381
# }
__label_3: # endif
.annotate 'line', 394
# var acc: $P5
root_new $P9, ['parrot';'ResizablePMCArray']
set $P5, $P9
# for loop
.annotate 'line', 395
# int i: $I2
null $I2
goto __label_7
__label_5: # for iteration
set $I7, $I2
inc $I2
__label_7: # for condition
islt $I8, $I2, $I1
unless $I8 goto __label_6 # for end
.annotate 'line', 396
root_new $P9, ['parrot';'ResizablePMCArray']
$P12 = $P4[$I2]
$P11 = 'jit_prefix_type'($P12)
$P9.'push'($P11)
# predefined sprintf
sprintf $S9, '%s', $P9
$P5[$I2] = $S9
goto __label_5 # for iteration
__label_6: # for end
.annotate 'line', 397
# string arg_t: $S4
# predefined join
join $S4, ', ', $P5
.annotate 'line', 399
# string ret_t: $S5
$P12 = $P3[1]
$P11 = 'jit_prefix_type'($P12)
null $S5
if_null $P11, __label_8
set $S5, $P11
__label_8:
.annotate 'line', 401
root_new $P13, ['parrot';'ResizablePMCArray']
set $P5, $P13
# for loop
.annotate 'line', 402
# int i: $I3
null $I3
goto __label_11
__label_9: # for iteration
set $I8, $I3
inc $I3
__label_11: # for condition
islt $I9, $I3, $I1
unless $I9 goto __label_10 # for end
.annotate 'line', 403
root_new $P14, ['parrot';'ResizablePMCArray']
box $P15, $I3
$P14.'push'($P15)
# predefined sprintf
sprintf $S10, 'v%d', $P14
$P13 = $P5.'push'($S10)
goto __label_9 # for iteration
__label_10: # for end
.annotate 'line', 404
# string arg_v: $S6
# predefined join
join $S6, ', ', $P5
.annotate 'line', 406
root_new $P15, ['parrot';'ResizablePMCArray']
set $P5, $P15
# for loop
.annotate 'line', 407
# int i: $I4
null $I4
goto __label_14
__label_12: # for iteration
set $I9, $I4
inc $I4
__label_14: # for condition
islt $I10, $I4, $I1
unless $I10 goto __label_13 # for end
.annotate 'line', 408
$P16 = $P5.'push'(', jit_value_t')
goto __label_12 # for iteration
__label_13: # for end
.annotate 'line', 409
# string arg_decls_t: $S7
# predefined join
join $S7, '', $P5
.annotate 'line', 411
root_new $P17, ['parrot';'ResizablePMCArray']
set $P5, $P17
# for loop
.annotate 'line', 412
# int i: $I5
null $I5
goto __label_17
__label_15: # for iteration
set $I10, $I5
inc $I5
__label_17: # for condition
islt $I11, $I5, $I1
unless $I11 goto __label_16 # for end
.annotate 'line', 413
root_new $P18, ['parrot';'ResizablePMCArray']
box $P19, $I5
$P18.'push'($P19)
# predefined sprintf
sprintf $S10, ', jit_value_t v%d', $P18
$P17 = $P5.'push'($S10)
goto __label_15 # for iteration
__label_16: # for end
.annotate 'line', 414
# string arg_decls_v: $S8
# predefined join
join $S8, '', $P5
.annotate 'line', 416
root_new $P20, ['parrot';'Hash']
.annotate 'line', 417
root_new $P21, ['parrot';'ResizablePMCArray']
box $P22, $S1
$P21.'push'($P22)
box $P22, $S7
$P21.'push'($P22)
# predefined sprintf
sprintf $S11, $S2, $P21
$P20['decl'] = $S11
.annotate 'line', 419
root_new $P23, ['parrot';'ResizablePMCArray']
box $P24, $S1
$P23.'push'($P24)
box $P24, $S8
$P23.'push'($P24)
box $P24, $I1
$P23.'push'($P24)
box $P24, $S4
$P23.'push'($P24)
box $P24, $S6
$P23.'push'($P24)
box $P24, $S5
$P23.'push'($P24)
box $P24, $S1
$P23.'push'($P24)
box $P24, $S1
$P23.'push'($P24)
# predefined sprintf
.annotate 'line', 418
sprintf $S12, $S3, $P23
$P20['defn'] = $S12
.annotate 'line', 416
$P19 = $P2.'push'($P20)
# }
goto __label_0
__label_1: # endfor
.annotate 'line', 423
.return($P2)
# }
.annotate 'line', 424

.end # gen_function_wrappers

# End generated code
