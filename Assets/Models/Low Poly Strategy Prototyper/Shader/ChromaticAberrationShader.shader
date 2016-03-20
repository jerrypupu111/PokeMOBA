Shader "Hidden/ChromaticAberration" {
Properties {
 _MainTex ("Base", 2D) = "" {}
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
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
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
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedgcclnnbgpijgpddakojponflfpghdgniabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmldjmmohbhmjmnnblgkeoagbliecmmbkabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.25, 0.5, -0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xy, c[1].yzzw;
MAD R1.zw, R1.xyxy, -c[0].xyxy, fragment.texcoord[0].xyxy;
MAD R0.zw, R1.x, -c[0].xyxy, fragment.texcoord[0].xyxy;
MAD R0.xy, R1.x, c[0], fragment.texcoord[0];
MAD R1.xy, R1, c[0], fragment.texcoord[0];
TEX R3, R1.zwzw, texture[0], 2D;
TEX R2, R1, texture[0], 2D;
TEX R1, R0.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[1].x;
END
# 13 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c1, 0.50000000, -0.50000000, 0.25000000, 0
dcl t0.xy
mov r1.xy, c0
mad r3.xy, c1.x, r1, t0
mov r0.xy, c0
mad r2.xy, c1.x, -r0, t0
mov r0.xy, c0
mov r1.xy, c0
mad r0.xy, c1, -r0, t0
mad r1.xy, c1, r1, t0
texld r0, r0, s0
texld r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
add_pp r2, r3, r2
add_pp r1, r2, r1
add_pp r0, r1, r0
mul_pp r0, r0, c1.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedapabkmokgejhfnafgafobaldeccdhcjaabaaaaaajaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaabaaaa
eaaaaaaaheaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaopcaabaaaacaaaaaaegiecaia
ebaaaaaaaaaaaaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadodoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgkmcemddfaelkpfdholaoiaipnjjlgkhabaaaaaapaadaaaaaeaaaaaa
daaaaaaaimabaaaageadaaaalmadaaaaebgpgodjfeabaaaafeabaaaaaaacpppp
caabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadpaaaaaalp
aaaaiadoaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadiaaaaaoekaaaaaaaiaaaaaoela
aeaaaaaeacaaadiaaaaaoekaaaaaaaibaaaaoelaaeaaaaaeadaaadiaaaaaoeka
aaaaoeiaaaaaoelaaeaaaaaeaaaaadiaaaaaoekaaaaaoeibaaaaoelaecaaaaad
abaacpiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaacaaaaad
abaacpiaabaaoeiaacaaoeiaacaaaaadabaacpiaadaaoeiaabaaoeiaacaaaaad
aaaacpiaaaaaoeiaabaaoeiaafaaaaadaaaacpiaaaaaoeiaabaakkkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadcaaaaanpcaabaaaaaaaaaaaegiecaaaaaaaaaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalpegbebaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaopcaabaaaacaaaaaaegiecaiaebaaaaaaaaaaaaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalpegbebaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
doaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
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
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
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
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedgcclnnbgpijgpddakojponflfpghdgniabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmldjmmohbhmjmnnblgkeoagbliecmmbkabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_ChromaticAberration]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0.5, 2 } };
TEMP R0;
TEMP R1;
TEX result.color.xzw, fragment.texcoord[0], texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], -c[2].x;
MUL R0.zw, R0.xyxy, c[2].y;
MOV R0.x, c[1];
MUL R1.xy, R0.zwzw, R0.zwzw;
MUL R0.xy, R0.x, c[0];
ADD R1.x, R1, R1.y;
MUL R0.xy, R0, R0.zwzw;
MAD R0.xy, -R0, R1.x, fragment.texcoord[0];
TEX result.color.y, R0, texture[0], 2D;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_ChromaticAberration]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c2, -0.50000000, 2.00000000, 0.00010002, 0
dcl t0.xy
add_pp r0.xy, t0, c2.x
mul_pp r1.xy, r0, c2.y
mul_pp r0.xy, r1, r1
mov r2.xy, c0
mul r2.xy, c1.x, r2
mul r1.xy, r2, r1
add_pp r0.x, r0, r0.y
mad r0.xy, -r1, r0.x, t0
texld r0, r0, s0
texld r1, t0, s0
mul_pp r0.x, r1.y, c2.z
add r1.y, r0.x, r0
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_ChromaticAberration]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkgjflmphaeahklknimhlpljeahimhimoabaaaaaafaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaabaaaa
eaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaadiaaaaajdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaaaaaaaakmcaabaaa
aaaaaaaaagbebaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaalpaaaaaalp
aaaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaakgaobaaaaaaaaaaadiaaaaah
dcaabaaaaaaaaaaaogakbaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaakgakbaaaaaaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafnccabaaa
aaaaaaaaagaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_ChromaticAberration]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfhpeaianfijfljkjgilhlodhehhkllocabaaaaaaheadaaaaaeaaaaaa
daaaaaaafaabaaaaoiacaaaaeaadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
oeaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaalpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaaadiaaaaaoekaafaaaaadaaaaadiaaaaaoeiaabaaaakaacaaaaad
aaaacmiaaaaabllaacaaaakaacaaaaadabaacdiaaaaabliaaaaabliaafaaaaad
aaaaadiaaaaaoeiaabaaoeiafkaaaaaeaaaaceiaabaaoeiaabaaoeiaacaaffka
aeaaaaaeaaaacdiaaaaaoeiaaaaakkibaaaaoelaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaaaaaoelaaaaioekaabaaaaacabaacciaaaaaffia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcjaabaaaaeaaaaaaageaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaadiaaaaajdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaaaaaaaaakmcaabaaaaaaaaaaaagbebaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaakgaobaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaa
aaaaaaaaogakbaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaakgakbaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafcccabaaa
aaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafnccabaaaaaaaaaaaagaobaaa
aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
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
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
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
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedgcclnnbgpijgpddakojponflfpghdgniabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmldjmmohbhmjmnnblgkeoagbliecmmbkabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_ChromaticAberration]
Float 2 [_AxialAberration]
Float 3 [_Luminance]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[11] = { program.local[0..3],
		{ 0.19995117, 0.5, 2, 2.5 },
		{ -2.5, -0.92626953, -0.40576172, 0.10865875 },
		{ -0.69580078, 0.45703125, -0.20336914, 0.82080078 },
		{ 0.96240234, -0.19494629, 0.47338867, -0.47998047 },
		{ 0.51953125, 0.76708984, 0.1854248, -0.89306641 },
		{ 0.89648438, 0.41235352, -0.32202148, -0.93261719 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
ADD R0.xy, fragment.texcoord[0], -c[4].y;
MUL R0.xy, R0, c[4].z;
MUL R0.xy, R0, R0;
ADD R0.x, R0, R0.y;
MUL R0.y, R0.x, c[1].x;
MUL R0.x, R0.y, R0;
MAX R0.x, R0, c[2];
MIN R0.x, R0, c[4].w;
MAX R0.x, R0, c[5];
MUL R0.xy, R0.x, c[0];
MAD R3.zw, R0.xyxy, c[8].xyxy, fragment.texcoord[0].xyxy;
MAD R4.xy, R0, c[8].zwzw, fragment.texcoord[0];
MAD R4.zw, R0.xyxy, c[9].xyxy, fragment.texcoord[0].xyxy;
MAD R5.xy, R0, c[9].zwzw, fragment.texcoord[0];
MAD R1.zw, R0.xyxy, c[6], fragment.texcoord[0].xyxy;
MAD R2.zw, R0.xyxy, c[7].xyxy, fragment.texcoord[0].xyxy;
MAD R3.xy, R0, c[7].zwzw, fragment.texcoord[0];
MAD R2.xy, R0, c[6], fragment.texcoord[0];
MAD R1.xy, R0, c[5].yzzw, fragment.texcoord[0];
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R9.xyz, R5, texture[0], 2D;
TEX R8.xyz, R4.zwzw, texture[0], 2D;
TEX R7.xyz, R4, texture[0], 2D;
TEX R4.xyz, R2.zwzw, texture[0], 2D;
TEX R6.xyz, R3.zwzw, texture[0], 2D;
TEX R5.xyz, R3, texture[0], 2D;
TEX R3.xyz, R1.zwzw, texture[0], 2D;
TEX R1.xyz, R1, texture[0], 2D;
TEX R2.xyz, R2, texture[0], 2D;
MAD R1.xyz, R0, c[4].x, R1;
ADD R1.xyz, R1, R2;
ADD R1.xyz, R1, R3;
ADD R1.xyz, R1, R4;
ADD R1.xyz, R1, R5;
ADD R1.xyz, R1, R6;
ADD R1.xyz, R1, R7;
ADD R1.xyz, R1, R8;
ADD R1.xyz, R1, R9;
MUL R1.xyz, R1, c[5].w;
DP3 R1.x, R1, c[10];
DP3 R1.w, R0, c[10];
ADD R1.x, R1, -R1.w;
ABS R1.x, R1;
ADD R1.y, R1, -R0;
MUL_SAT R1.x, R1, c[3];
MAD result.color.y, R1.x, R1, R0;
MOV result.color.xzw, R0;
END
# 47 instructions, 10 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_ChromaticAberration]
Float 2 [_AxialAberration]
Float 3 [_Luminance]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c4, -0.50000000, 2.00000000, 2.50000000, -2.50000000
def c5, -0.92626953, -0.40576172, -0.69580078, 0.45703125
def c6, 0.19995117, -0.20336914, 0.82080078, 0.10865875
def c7, 0.96240234, -0.19494629, 0.47338867, -0.47998047
def c8, 0.51953125, 0.76708984, 0.18542480, -0.89306641
def c9, 0.89648438, 0.41235352, -0.32202148, -0.93261719
def c10, 0.21997070, 0.70703125, 0.07098389, 0
dcl t0.xy
texld r9, t0, s0
add_pp r0.xy, t0, c4.x
mul_pp r0.xy, r0, c4.y
mul_pp r0.xy, r0, r0
add_pp r0.x, r0, r0.y
mul_pp r1.x, r0, c1
mul_pp r0.x, r1, r0
max_pp r0.x, r0, c2
min_pp r0.x, r0, c4.z
max_pp r0.x, r0, c4.w
mul r1.xy, r0.x, c0
mad r8.xy, r1, c5, t0
mad r6.xy, r1, c6.yzxw, t0
mad r5.xy, r1, c7, t0
mad r3.xy, r1, c8, t0
mov r0.y, c5.w
mov r0.x, c5.z
mad r7.xy, r1, r0, t0
mov r0.y, c7.w
mov r0.x, c7.z
mad r4.xy, r1, r0, t0
mov r0.y, c8.w
mov r0.x, c8.z
mad r2.xy, r1, r0, t0
mov r0.y, c9.w
mov r0.x, c9.z
mad r0.xy, r1, r0, t0
mad r1.xy, r1, c9, t0
texld r2, r2, s0
texld r0, r0, s0
texld r1, r1, s0
texld r3, r3, s0
texld r4, r4, s0
texld r5, r5, s0
texld r6, r6, s0
texld r7, r7, s0
texld r8, r8, s0
mad_pp r8.xyz, r9, c6.x, r8
add_pp r7.xyz, r8, r7
add_pp r6.xyz, r7, r6
add_pp r5.xyz, r6, r5
add_pp r4.xyz, r5, r4
add_pp r3.xyz, r4, r3
add_pp r2.xyz, r3, r2
add_pp r1.xyz, r2, r1
add_pp r0.xyz, r1, r0
mul_pp r1.xyz, r0, c6.w
dp3_pp r1.x, r1, c10
dp3_pp r0.x, r9, c10
add_pp r0.x, r1, -r0
abs_pp r0.x, r0
mul_pp_sat r0.x, r0, c3
add_pp r1.x, r1.y, -r9.y
mov_pp r2.xzw, r9
mad_pp r2.y, r0.x, r1.x, r9
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_ChromaticAberration]
Float 36 [_AxialAberration]
Float 40 [_Luminance]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmooiobcebaldiingpabcfbncgibkdolfabaaaaaaaiafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiaeaaaa
eaaaaaaabcabaaaadfbiaaaacgaaaaaadlbmgnlpfemgmploaaaaaaaaaaaaaaaa
glchdclpnmanokdoaaaaaaaaaaaaaaaakmdjfalohcbkfcdpaaaaaaaaaaaaaaaa
okflhgdpkakjehloaaaaaaaaaaaaaaaapbgfpcdopimfpfloaaaaaaaaaaaaaaaa
bcplaedpiofleedpaaaaaaaaaaaaaaaahnojdndomgkdgelpaaaaaaaaaaaaaaaa
mihlgfdplccnnddoaaaaaaaaaaaaaaaafcnfkelonllpgolpaaaaaaaaaaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaaaaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaacaaaaaadeaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacamaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaacaeadiaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaaaceaaaaaaaaaaaaa
mnmmemdomnmmemdomnmmemdodgaaaaafhcaabaaaacaaaaaajgahbaaaaaaaaaaa
dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaajaaaaaaadaaaeadakaabaaaadaaaaaa
diaaaaajdcaabaaaadaaaaaaegiacaaaaaaaaaaaabaaaaaaegjajaaadkaabaaa
acaaaaaadcaaaaajdcaabaaaadaaaaaaegaabaaaadaaaaaaagaabaaaaaaaaaaa
egbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaboaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
abaaaaaabgaaaaabdiaaaaakhcaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
nejlnodnnejlnodnnejlnodnaaaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaabaaaaaakccaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
dicaaaajbcaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaackiacaaaaaaaaaaa
acaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaacaaaaaaabeaaaaanejlnodn
bkaabaiaebaaaaaaabaaaaaadcaaaaajcccabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaabaaaaaadgaaaaafnccabaaaaaaaaaaaagaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_ChromaticAberration]
Float 36 [_AxialAberration]
Float 40 [_Luminance]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedflehobbifhiihijfginfddifjfedmnmpabaaaaaakiajaaaaaeaaaaaa
daaaaaaammaeaaaabmajaaaaheajaaaaebgpgodjjeaeaaaajeaeaaaaaaacpppp
gaaeaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaalpaaaaaaaa
aaaacamaaaaacaeafbaaaaafadaaapkadlbmgnlpfemgmplomnmmemdonejlnodn
fbaaaaafaeaaapkakoehgbdopepndedphdgijbdnaaaaaaaafbaaaaafafaaapka
mihlgfdplccnnddonllpgolpfcnfkelofbaaaaafagaaapkabcplaedpiofleedp
mgkdgelphnojdndofbaaaaafahaaapkaokflhgdpkakjehlopimfpflopbgfpcdo
fbaaaaafaiaaapkaglchdclpnmanokdohcbkfcdpkmdjfalobpaaaaacaaaaaaia
aaaacdlabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaaaaaoekaafaaaaad
aaaaamiaaaaabliaaiaablkaacaaaaadabaacdiaaaaaoelaacaaaakaacaaaaad
abaacdiaabaaoeiaabaaoeiafkaaaaaeabaacbiaabaaoeiaabaaoeiaacaaffka
afaaaaadabaacbiaabaaaaiaabaaaaiaafaaaaadabaacbiaabaaaaiaabaaaaka
alaaaaadacaaciiaabaaffkaabaaaaiaalaaaaadabaacbiaacaappiaacaakkka
akaaaaadacaacbiaabaaaaiaacaappkaaeaaaaaeabaacdiaaaaabliaacaaaaia
aaaaoelaafaaaaadaaaaamiaaaaabliaadaablkaaeaaaaaeadaacdiaaaaablia
acaaaaiaaaaaoelaafaaaaadaaaaamiaaaaabliaaiaaoekaaeaaaaaeaeaacdia
aaaabliaacaaaaiaaaaaoelaafaaaaadaaaaamiaaaaabliaahaablkaaeaaaaae
afaacdiaaaaabliaacaaaaiaaaaaoelaafaaaaadaaaaamiaaaaabliaahaaoeka
aeaaaaaeagaacdiaaaaabliaacaaaaiaaaaaoelaafaaaaadaaaaamiaaaaablia
agaablkaaeaaaaaeahaacdiaaaaabliaacaaaaiaaaaaoelaafaaaaadaaaaamia
aaaabliaagaaoekaaeaaaaaeaiaacdiaaaaabliaacaaaaiaaaaaoelaafaaaaad
aaaaamiaaaaabliaafaablkaaeaaaaaeajaacdiaaaaabliaacaaaaiaaaaaoela
afaaaaadaaaaadiaaaaaoeiaafaablkaaeaaaaaeaaaacdiaaaaaoeiaacaaaaia
aaaaoelaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpiaadaaoeia
aaaioekaecaaaaadadaacpiaaaaaoelaaaaioekaecaaaaadaeaacpiaaeaaoeia
aaaioekaecaaaaadafaacpiaafaaoeiaaaaioekaecaaaaadagaacpiaagaaoeia
aaaioekaecaaaaadahaacpiaahaaoeiaaaaioekaecaaaaadaiaacpiaaiaaoeia
aaaioekaecaaaaadajaacpiaajaaoeiaaaaioekaecaaaaadaaaacpiaaaaaoeia
aaaioekaaeaaaaaeacaachiaadaaoeiaadaakkkaacaaoeiaacaaaaadabaachia
abaaoeiaacaaoeiaacaaaaadabaachiaaeaaoeiaabaaoeiaacaaaaadabaachia
afaaoeiaabaaoeiaacaaaaadabaachiaagaaoeiaabaaoeiaacaaaaadabaachia
ahaaoeiaabaaoeiaacaaaaadabaachiaaiaaoeiaabaaoeiaacaaaaadabaachia
ajaaoeiaabaaoeiaacaaaaadaaaachiaaaaaoeiaabaaoeiaafaaaaadabaachia
aaaaoeiaadaappkaaeaaaaaeabaaciiaaaaaffiaadaappkaadaaffibaiaaaaad
aaaacbiaabaaoeiaaeaaoekaaiaaaaadaaaacciaadaaoeiaaeaaoekaacaaaaad
aaaacbiaaaaaffibaaaaaaiacdaaaaacaaaacbiaaaaaaaiaafaaaaadaaaadbia
aaaaaaiaabaakkkaaeaaaaaeadaacciaaaaaaaiaabaappiaadaaffiaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefceiaeaaaaeaaaaaaabcabaaaadfbiaaaa
cgaaaaaadlbmgnlpfemgmploaaaaaaaaaaaaaaaaglchdclpnmanokdoaaaaaaaa
aaaaaaaakmdjfalohcbkfcdpaaaaaaaaaaaaaaaaokflhgdpkakjehloaaaaaaaa
aaaaaaaapbgfpcdopimfpfloaaaaaaaaaaaaaaaabcplaedpiofleedpaaaaaaaa
aaaaaaaahnojdndomgkdgelpaaaaaaaaaaaaaaaamihlgfdplccnnddoaaaaaaaa
aaaaaaaafcnfkelonllpgolpaaaaaaaaaaaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaaaaaaaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaacaaaaaa
deaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacamaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacaeadiaaaaakocaabaaa
aaaaaaaaagajbaaaabaaaaaaaceaaaaaaaaaaaaamnmmemdomnmmemdomnmmemdo
dgaaaaafhcaabaaaacaaaaaajgahbaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaaajaaaaaaadaaaeadakaabaaaadaaaaaadiaaaaajdcaabaaaadaaaaaa
egiacaaaaaaaaaaaabaaaaaaegjajaaadkaabaaaacaaaaaadcaaaaajdcaabaaa
adaaaaaaegaabaaaadaaaaaaagaabaaaaaaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaboaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaak
hcaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaanejlnodnnejlnodnnejlnodn
aaaaaaaabaaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaakoehgbdo
pepndedphdgijbdnaaaaaaaabaaaaaakccaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaakoehgbdopepndedphdgijbdnaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadicaaaajbcaabaaaaaaaaaaa
akaabaiaibaaaaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaadcaaaaakccaabaaa
aaaaaaaabkaabaaaacaaaaaaabeaaaaanejlnodnbkaabaiaebaaaaaaabaaaaaa
dcaaaaajcccabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadgaaaaafnccabaaaaaaaaaaaagaobaaaabaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}