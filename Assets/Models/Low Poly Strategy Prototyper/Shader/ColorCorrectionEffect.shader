Shader "Hidden/Color Correction Effect" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _RampTex ("Base (RGB)", 2D) = "grayscaleRamp" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[9] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
"vs_2_0
def c8, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c8.x
mov r0.xy, v1
dp4 oT0.y, r0, c5
dp4 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0
eefiecedeedelkdobbmimfefjdhgabnhlefmpcmlabaaaaaaciacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceiabaaaa
eaaaabaafcaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaccaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaacbaaaaaadcaaaaak
dccabaaaabaaaaaaegiacaaaabaaaaaacaaaaaaaagbabaaaabaaaaaaegaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0_level_9_1
eefieceddhnbicbokkmhnihbiniipgnpnicndjjjabaaaaaaceadaaaaaeaaaaaa
daaaaaaaciabaaaahiacaaaammacaaaaebgpgodjpaaaaaaapaaaaaaaaaacpopp
laaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaabaacaaaacaaafaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaadiaabaaffja
agaaoekaaeaaaaaeaaaaadoaafaaoekaabaaaajaaaaaoeiaafaaaaadaaaaapia
aaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefceiabaaaaeaaaabaafcaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaccaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaabaaaaaa
egiacaaaabaaaaaacbaaaaaadcaaaaakdccabaaaabaaaaaaegiacaaaabaaaaaa
caaaaaaaagbabaaaabaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 9.9999997e-006, 1.9999999e-005, 2.9999999e-005 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R0.z, R0.z, texture[1], 2D;
TEX R0.x, R0.x, texture[1], 2D;
TEX R0.y, R0.y, texture[1], 2D;
ADD result.color.x, R0, c[0];
ADD result.color.y, R0, c[0];
ADD result.color.z, R0, c[0];
MOV result.color.w, R0;
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 0.00001000, 0.00002000, 0.00003000, 0
dcl t0.xy
texld r3, t0, s0
mov r1.xy, r3.y
mov r0.xy, r3.z
mov r2.xy, r3.x
texld r2, r2, s1
texld r1, r1, s1
texld r0, r0, s1
add r0.x, r2, c0
add r0.y, r1, c0
mov_pp r0.w, r3
add r0.z, r0, c0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
"ps_4_0
eefiecedenmadkglkggmfejfhnkckocngobgilgjabaaaaaabmacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmabaaaa
eaaaaaaafhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahbccabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
kmmfchdhefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahcccabaaaaaaaaaaabkaabaaaabaaaaaaabeaaaaa
kmmfkhdhefaaaaajpcaabaaaabaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
eccabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaaickipldhdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
"ps_4_0_level_9_1
eefiecedmdccanekijldhoddgcglicgifcdebiinabaaaaaadiadaaaaaeaaaaaa
daaaaaaaeiabaaaakmacaaaaaeadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oeaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkakmmfchdhkmmfkhdhickipldhaaaaaaaa
bpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaacdiaaaaaaaia
abaaaaacacaacdiaaaaaffiaabaaaaacadaacdiaaaaakkiaecaaaaadabaaapia
abaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaadadaaapia
adaaoeiaabaioekaacaaaaadaaaacbiaabaaaaiaaaaaaakaacaaaaadaaaaccia
acaaffiaaaaaffkaacaaaaadaaaaceiaadaakkiaaaaakkkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcfmabaaaaeaaaaaaafhaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahbccabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaakmmfchdhefaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahcccabaaa
aaaaaaaabkaabaaaabaaaaaaabeaaaaakmmfkhdhefaaaaajpcaabaaaabaaaaaa
kgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaaheccabaaaaaaaaaaackaabaaaabaaaaaa
abeaaaaaickipldhdoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}