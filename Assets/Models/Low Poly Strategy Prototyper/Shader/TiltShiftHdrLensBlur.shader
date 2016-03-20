Shader "Hidden/Dof/TiltShiftHdrLensBlur" {
Properties {
 _MainTex ("-", 2D) = "" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform float _BlurArea;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = vec4((abs((((xlv_TEXCOORD0 * 2.0) - 1.0).y * _BlurArea)) * 0.5));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 0 [_BlurArea]
"ps_3_0
def c1, 2.00000000, -1.00000000, 0.50000000, 0
dcl_texcoord0 v0.xy
mad r0.x, v0.y, c1, c1.y
mul r0.x, r0, c0
abs r0.x, r0
mul oC0, r0.x, c1.z
"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 48
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecednhopbjdgefnbnllbfkicofehgofeelemabaaaaaaieabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadacaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmaaaaaaeaaaaaaaclaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaadccbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaadcaaaaajbcaabaaaaaaaaaaabkbabaaa
abaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaadiaaaaalpccabaaaaaaaaaaa
agaabaiaibaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadp
doaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform float _BlurArea;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = ((xlv_TEXCOORD0 * 2.0) - 1.0);
  gl_FragData[0] = vec4(((dot (tmpvar_1, tmpvar_1) * _BlurArea) * 0.5));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 0 [_BlurArea]
"ps_3_0
def c1, 2.00000000, -1.00000000, 0.50000000, 0
dcl_texcoord0 v0.xy
mad r0.xy, v0, c1.x, c1.y
mul r0.xy, r0, r0
add r0.x, r0, r0.y
mul r0.x, r0, c0
mul oC0, r0.x, c1.z
"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 48
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoedkflcfloofanhmghnmncdjfmljmecbabaaaaaaleabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmaaaaaaeaaaaaaadhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaadcaaaaapdcaabaaaaaaaaaaaegbabaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaaacaaaaaadiaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaadpdoaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
uniform float _BlurSize;
uniform float _BlurArea;
vec3 DiscKernel[28];
varying vec2 xlv_TEXCOORD0;
void main ()
{
  DiscKernel[0] = vec3(0.62463, 0.54337, 0.8279);
  DiscKernel[1] = vec3(-0.13414, -0.94488, 0.95435);
  DiscKernel[2] = vec3(0.38772, -0.43475, 0.58253);
  DiscKernel[3] = vec3(0.12126, -0.19282, 0.22778);
  DiscKernel[4] = vec3(-0.20388, 0.11133, 0.2323);
  DiscKernel[5] = vec3(0.83114, -0.29218, 0.881);
  DiscKernel[6] = vec3(0.10759, -0.57839, 0.58831);
  DiscKernel[7] = vec3(0.28285, 0.79036, 0.83945);
  DiscKernel[8] = vec3(-0.36622, 0.39516, 0.53876);
  DiscKernel[9] = vec3(0.75591, 0.21916, 0.78704);
  DiscKernel[10] = vec3(-0.5261, 0.02386, 0.52664);
  DiscKernel[11] = vec3(-0.88216, -0.24471, 0.91547);
  DiscKernel[12] = vec3(-0.48888, -0.2933, 0.57011);
  DiscKernel[13] = vec3(0.44014, -0.08558, 0.44838);
  DiscKernel[14] = vec3(0.21179, 0.51373, 0.55567);
  DiscKernel[15] = vec3(0.05483, 0.95701, 0.95858);
  DiscKernel[16] = vec3(-0.59001, -0.70509, 0.91938);
  DiscKernel[17] = vec3(-0.80065, 0.24631, 0.83768);
  DiscKernel[18] = vec3(-0.19424, -0.18402, 0.26757);
  DiscKernel[19] = vec3(-0.43667, 0.76751, 0.88304);
  DiscKernel[20] = vec3(0.21666, 0.11602, 0.24577);
  DiscKernel[21] = vec3(0.15696, -0.856, 0.87027);
  DiscKernel[22] = vec3(-0.75821, 0.58363, 0.95682);
  DiscKernel[23] = vec3(0.99284, -0.02904, 0.99327);
  DiscKernel[24] = vec3(-0.22234, -0.57907, 0.62029);
  DiscKernel[25] = vec3(0.55052, -0.66984, 0.86704);
  DiscKernel[26] = vec3(0.46431, 0.28115, 0.5428);
  DiscKernel[27] = vec3(-0.07214, 0.60554, 0.60982);
  vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  vec4 tmpvar_2;
  int l_3;
  vec4 poissonScale_4;
  vec4 sum_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  sum_5 = tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = clamp (abs((((xlv_TEXCOORD0 * 2.0) - 1.0).y * _BlurArea)), 0.0, _BlurSize);
  poissonScale_4 = (_MainTex_TexelSize.xyxy * tmpvar_7);
  if ((tmpvar_7 < 0.01)) {
    tmpvar_2 = tmpvar_6;
  } else {
    l_3 = 0;
    for (int l_3 = 0; l_3 < 28; ) {
      sum_5 = (sum_5 + texture2D (_MainTex, (tmpvar_1 + (DiscKernel[l_3].xy * poissonScale_4.xy))));
      l_3 = (l_3 + 1);
    };
    vec4 tmpvar_8;
    tmpvar_8.xyz = (sum_5.xyz / 29.0);
    tmpvar_8.w = tmpvar_7;
    tmpvar_2 = tmpvar_8;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_BlurSize]
Float 2 [_BlurArea]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 2.00000000, -1.00000000, 0.00000000, 0.03448276
def c4, -0.07214000, 0.60553998, 0.62462997, 0.54337001
def c5, -0.13414000, -0.94488001, 0.38771999, -0.43474999
def c6, 0.12126000, -0.19282000, -0.20388000, 0.11133000
def c7, 0.83113998, -0.29218000, 0.10759000, -0.57839000
def c8, 0.28285000, 0.79035997, -0.36622000, 0.39515999
def c9, 0.75590998, 0.21916001, -0.52609998, 0.02386000
def c10, -0.88216001, -0.24471000, -0.48888001, -0.29330000
def c11, 0.44014001, -0.08558000, 0.21179000, 0.51372999
def c12, 0.05483000, 0.95700997, -0.59000999, -0.70508999
def c13, -0.80065000, 0.24631000, -0.19424000, -0.18402000
def c14, -0.43667001, 0.76751000, 0.21665999, 0.11602000
def c15, 0.15696000, -0.85600001, -0.75821000, 0.58363003
def c16, 0.99283999, -0.02904000, -0.22234000, -0.57906997
def c17, 0.55052000, -0.66983998, 0.46430999, 0.28115001
dcl_texcoord0 v0.xy
mad r0.x, v0.y, c3, c3.y
mul r0.x, r0, c2
abs r0.x, r0
min r0.x, r0, c1
max r0.w, r0.x, c3.z
mul r3.xy, r0.w, c0
mad r1.xy, r3, c5, v0
mad r0.xy, r3, c4.zwzw, v0
texld r2.xyz, r1, s0
texld r1.xyz, r0, s0
texld r0.xyz, v0, s0
add r0.xyz, r0, r1
add r2.xyz, r0, r2
mad r0.xy, r3, c5.zwzw, v0
mad r1.xy, r3, c6, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c6.zwzw, v0
mad r1.xy, r3, c7, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c7.zwzw, v0
mad r1.xy, r3, c8, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c8.zwzw, v0
mad r1.xy, r3, c9, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c9.zwzw, v0
mad r1.xy, r3, c10, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c10.zwzw, v0
mad r1.xy, r3, c11, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c11.zwzw, v0
mad r1.xy, r3, c12, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c12.zwzw, v0
mad r1.xy, r3, c13, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c13.zwzw, v0
mad r1.xy, r3, c14, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c14.zwzw, v0
mad r1.xy, r3, c15, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c15.zwzw, v0
mad r1.xy, r3, c16, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c16.zwzw, v0
mad r1.xy, r3, c17, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r0.xyz, r0, r1
mad r2.xy, r3, c17.zwzw, v0
mad r1.xy, r3, c4, v0
texld r2.xyz, r2, s0
texld r1.xyz, r1, s0
add r0.xyz, r0, r2
add r0.xyz, r0, r1
mul oC0.xyz, r0, c3.w
mov oC0.w, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_BlurSize]
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecednofnbemnhebhaaomankenjpfapjkacplabaaaaaaaiafaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaaeaaaaeaaaaaaaamabaaaa
dfbiaaaahcaaaaaamaohbpdpembkaldpebpbfddpaaaaaaaappflajlokiodhblp
eifahedpaaaaaaaadmidmgdoinjhnololacabfdpaaaaaaaackfhpidnjlhceflo
cjdpgjdoaaaaaaaaolmffalopmaaoednanoagndoaaaaaaaajhmffedpjojijflo
dhijgbdpaaaaaaaacffinmdnfobbbelphmjlbgdpaaaaaaaalhnbjadoaiffekdp
dcogfgdpaaaaaaaadaiblllogjfcmkdocnomajdpaaaaaaaafbidebdphlglgado
hehlejdpaaaaaaaahnkoaglpamhgmddmobnbagdpaaaaaaaadnnfgblpecjfhklo
dofmgkdpaaaaaaaahleopkloglcljglollpcbbdpaaaaaaaaaifkobdojbeekpln
bajcofdoaaaaaaaahknpfidompidaddpgeeaaodpaaaaaaaagmjfgadnjlpohedp
iagfhfdpaaaaaaaaofakbhlpmhiadelphnfmgldpaaaaaaaaggphemlpladihmdo
dchcfgdpaaaaaaaankogeglolngpdmlooppoiidoaaaaaaaadgjdnploijhleedp
ojaogcdpaaaaaaaabonmfndoofjlondnccklhldoaaaaaaaabplkcadonbccfllp
aemkfodpaaaaaaaaanbkeclpmhgibfdpcipchedpaaaaaaaamdckhodpelofonlm
pbeghodpaaaaaaaabjkngdlooodnbelpfdmlbodpaaaaaaaaobooamdpkchkcllp
ffpgfndpaaaaaaaaaklkondoofpcipdopbpeakdpaaaaaaaacdlojdlnklaebldp
ckbnbmdpaaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaabkbabaaaabaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaacaaaaaaddaaaaaj
bcaabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaa
dbaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaknhcddmbpaaaead
bkaabaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab
bfaaaaabdiaaaaaigcaabaaaabaaaaaaagaabaaaabaaaaaaagibcaaaaaaaaaaa
abaaaaaadgaaaaafhcaabaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaabmaaaaaaadaaaeaddkaabaaaabaaaaaadcaaaaakdcaabaaa
adaaaaaaegjajaaadkaabaaaaaaaaaaajgafbaaaabaaaaaaegbabaaaabaaaaaa
eiaaaaalpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaboaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
abaaaaaabgaaaaabdiaaaaakhccabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
mldnandnmldnandnmldnandnaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
abaaaaaadoaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
uniform float _BlurSize;
uniform float _BlurArea;
vec3 DiscKernel[28];
varying vec2 xlv_TEXCOORD0;
void main ()
{
  DiscKernel[0] = vec3(0.62463, 0.54337, 0.8279);
  DiscKernel[1] = vec3(-0.13414, -0.94488, 0.95435);
  DiscKernel[2] = vec3(0.38772, -0.43475, 0.58253);
  DiscKernel[3] = vec3(0.12126, -0.19282, 0.22778);
  DiscKernel[4] = vec3(-0.20388, 0.11133, 0.2323);
  DiscKernel[5] = vec3(0.83114, -0.29218, 0.881);
  DiscKernel[6] = vec3(0.10759, -0.57839, 0.58831);
  DiscKernel[7] = vec3(0.28285, 0.79036, 0.83945);
  DiscKernel[8] = vec3(-0.36622, 0.39516, 0.53876);
  DiscKernel[9] = vec3(0.75591, 0.21916, 0.78704);
  DiscKernel[10] = vec3(-0.5261, 0.02386, 0.52664);
  DiscKernel[11] = vec3(-0.88216, -0.24471, 0.91547);
  DiscKernel[12] = vec3(-0.48888, -0.2933, 0.57011);
  DiscKernel[13] = vec3(0.44014, -0.08558, 0.44838);
  DiscKernel[14] = vec3(0.21179, 0.51373, 0.55567);
  DiscKernel[15] = vec3(0.05483, 0.95701, 0.95858);
  DiscKernel[16] = vec3(-0.59001, -0.70509, 0.91938);
  DiscKernel[17] = vec3(-0.80065, 0.24631, 0.83768);
  DiscKernel[18] = vec3(-0.19424, -0.18402, 0.26757);
  DiscKernel[19] = vec3(-0.43667, 0.76751, 0.88304);
  DiscKernel[20] = vec3(0.21666, 0.11602, 0.24577);
  DiscKernel[21] = vec3(0.15696, -0.856, 0.87027);
  DiscKernel[22] = vec3(-0.75821, 0.58363, 0.95682);
  DiscKernel[23] = vec3(0.99284, -0.02904, 0.99327);
  DiscKernel[24] = vec3(-0.22234, -0.57907, 0.62029);
  DiscKernel[25] = vec3(0.55052, -0.66984, 0.86704);
  DiscKernel[26] = vec3(0.46431, 0.28115, 0.5428);
  DiscKernel[27] = vec3(-0.07214, 0.60554, 0.60982);
  vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  vec4 tmpvar_2;
  int l_3;
  vec4 poissonScale_4;
  vec4 sum_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  sum_5 = tmpvar_6;
  vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0 * 2.0) - 1.0);
  float tmpvar_8;
  tmpvar_8 = clamp ((dot (tmpvar_7, tmpvar_7) * _BlurArea), 0.0, _BlurSize);
  poissonScale_4 = (_MainTex_TexelSize.xyxy * tmpvar_8);
  if ((tmpvar_8 < 0.01)) {
    tmpvar_2 = tmpvar_6;
  } else {
    l_3 = 0;
    for (int l_3 = 0; l_3 < 28; ) {
      sum_5 = (sum_5 + texture2D (_MainTex, (tmpvar_1 + (DiscKernel[l_3].xy * poissonScale_4.xy))));
      l_3 = (l_3 + 1);
    };
    vec4 tmpvar_9;
    tmpvar_9.xyz = (sum_5.xyz / 29.0);
    tmpvar_9.w = tmpvar_8;
    tmpvar_2 = tmpvar_9;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_BlurSize]
Float 2 [_BlurArea]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 2.00000000, -1.00000000, 0.00000000, 0.03448276
def c4, -0.07214000, 0.60553998, 0.62462997, 0.54337001
def c5, -0.13414000, -0.94488001, 0.38771999, -0.43474999
def c6, 0.12126000, -0.19282000, -0.20388000, 0.11133000
def c7, 0.83113998, -0.29218000, 0.10759000, -0.57839000
def c8, 0.28285000, 0.79035997, -0.36622000, 0.39515999
def c9, 0.75590998, 0.21916001, -0.52609998, 0.02386000
def c10, -0.88216001, -0.24471000, -0.48888001, -0.29330000
def c11, 0.44014001, -0.08558000, 0.21179000, 0.51372999
def c12, 0.05483000, 0.95700997, -0.59000999, -0.70508999
def c13, -0.80065000, 0.24631000, -0.19424000, -0.18402000
def c14, -0.43667001, 0.76751000, 0.21665999, 0.11602000
def c15, 0.15696000, -0.85600001, -0.75821000, 0.58363003
def c16, 0.99283999, -0.02904000, -0.22234000, -0.57906997
def c17, 0.55052000, -0.66983998, 0.46430999, 0.28115001
dcl_texcoord0 v0.xy
mad r0.xy, v0, c3.x, c3.y
mul r0.xy, r0, r0
add r0.x, r0, r0.y
mul r0.x, r0, c2
min r0.x, r0, c1
max r0.w, r0.x, c3.z
mul r3.xy, r0.w, c0
mad r1.xy, r3, c5, v0
mad r0.xy, r3, c4.zwzw, v0
texld r2.xyz, r1, s0
texld r1.xyz, r0, s0
texld r0.xyz, v0, s0
add r0.xyz, r0, r1
add r2.xyz, r0, r2
mad r0.xy, r3, c5.zwzw, v0
mad r1.xy, r3, c6, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c6.zwzw, v0
mad r1.xy, r3, c7, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c7.zwzw, v0
mad r1.xy, r3, c8, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c8.zwzw, v0
mad r1.xy, r3, c9, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c9.zwzw, v0
mad r1.xy, r3, c10, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c10.zwzw, v0
mad r1.xy, r3, c11, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c11.zwzw, v0
mad r1.xy, r3, c12, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c12.zwzw, v0
mad r1.xy, r3, c13, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c13.zwzw, v0
mad r1.xy, r3, c14, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c14.zwzw, v0
mad r1.xy, r3, c15, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c15.zwzw, v0
mad r1.xy, r3, c16, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r2.xyz, r0, r1
mad r0.xy, r3, c16.zwzw, v0
mad r1.xy, r3, c17, v0
texld r0.xyz, r0, s0
add r0.xyz, r2, r0
texld r1.xyz, r1, s0
add r0.xyz, r0, r1
mad r2.xy, r3, c17.zwzw, v0
mad r1.xy, r3, c4, v0
texld r2.xyz, r2, s0
texld r1.xyz, r1, s0
add r0.xyz, r0, r2
add r0.xyz, r0, r1
mul oC0.xyz, r0, c3.w
mov oC0.w, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_BlurSize]
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahbnajplgcaghpinhneonejhnkmmpnilabaaaaaafeafaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmaeaaaaeaaaaaaabpabaaaa
dfbiaaaahcaaaaaamaohbpdpembkaldpebpbfddpaaaaaaaappflajlokiodhblp
eifahedpaaaaaaaadmidmgdoinjhnololacabfdpaaaaaaaackfhpidnjlhceflo
cjdpgjdoaaaaaaaaolmffalopmaaoednanoagndoaaaaaaaajhmffedpjojijflo
dhijgbdpaaaaaaaacffinmdnfobbbelphmjlbgdpaaaaaaaalhnbjadoaiffekdp
dcogfgdpaaaaaaaadaiblllogjfcmkdocnomajdpaaaaaaaafbidebdphlglgado
hehlejdpaaaaaaaahnkoaglpamhgmddmobnbagdpaaaaaaaadnnfgblpecjfhklo
dofmgkdpaaaaaaaahleopkloglcljglollpcbbdpaaaaaaaaaifkobdojbeekpln
bajcofdoaaaaaaaahknpfidompidaddpgeeaaodpaaaaaaaagmjfgadnjlpohedp
iagfhfdpaaaaaaaaofakbhlpmhiadelphnfmgldpaaaaaaaaggphemlpladihmdo
dchcfgdpaaaaaaaankogeglolngpdmlooppoiidoaaaaaaaadgjdnploijhleedp
ojaogcdpaaaaaaaabonmfndoofjlondnccklhldoaaaaaaaabplkcadonbccfllp
aemkfodpaaaaaaaaanbkeclpmhgibfdpcipchedpaaaaaaaamdckhodpelofonlm
pbeghodpaaaaaaaabjkngdlooodnbelpfdmlbodpaaaaaaaaobooamdpkchkcllp
ffpgfndpaaaaaaaaaklkondoofpcipdopbpeakdpaaaaaaaacdlojdlnklaebldp
ckbnbmdpaaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaa
abaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaabkiacaaaaaaaaaaaacaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaacaaaaaadbaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaknhcddmbpaaaeadbkaabaaaabaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadoaaaaabbfaaaaabdiaaaaaigcaabaaaabaaaaaaagaabaaa
abaaaaaaagibcaaaaaaaaaaaabaaaaaadgaaaaafhcaabaaaacaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaabmaaaaaaadaaaeaddkaabaaa
abaaaaaadcaaaaakdcaabaaaadaaaaaaegjajaaadkaabaaaaaaaaaaajgafbaaa
abaaaaaaegbabaaaabaaaaaaeiaaaaalpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaboaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaakhccabaaaaaaaaaaa
egacbaaaacaaaaaaaceaaaaamldnandnmldnandnmldnandnaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaakaabaaaabaaaaaadoaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
uniform float _BlurSize;
uniform float _BlurArea;
vec3 DiscKernel[28];
varying vec2 xlv_TEXCOORD0;
void main ()
{
  DiscKernel[0] = vec3(0.62463, 0.54337, 0.8279);
  DiscKernel[1] = vec3(-0.13414, -0.94488, 0.95435);
  DiscKernel[2] = vec3(0.38772, -0.43475, 0.58253);
  DiscKernel[3] = vec3(0.12126, -0.19282, 0.22778);
  DiscKernel[4] = vec3(-0.20388, 0.11133, 0.2323);
  DiscKernel[5] = vec3(0.83114, -0.29218, 0.881);
  DiscKernel[6] = vec3(0.10759, -0.57839, 0.58831);
  DiscKernel[7] = vec3(0.28285, 0.79036, 0.83945);
  DiscKernel[8] = vec3(-0.36622, 0.39516, 0.53876);
  DiscKernel[9] = vec3(0.75591, 0.21916, 0.78704);
  DiscKernel[10] = vec3(-0.5261, 0.02386, 0.52664);
  DiscKernel[11] = vec3(-0.88216, -0.24471, 0.91547);
  DiscKernel[12] = vec3(-0.48888, -0.2933, 0.57011);
  DiscKernel[13] = vec3(0.44014, -0.08558, 0.44838);
  DiscKernel[14] = vec3(0.21179, 0.51373, 0.55567);
  DiscKernel[15] = vec3(0.05483, 0.95701, 0.95858);
  DiscKernel[16] = vec3(-0.59001, -0.70509, 0.91938);
  DiscKernel[17] = vec3(-0.80065, 0.24631, 0.83768);
  DiscKernel[18] = vec3(-0.19424, -0.18402, 0.26757);
  DiscKernel[19] = vec3(-0.43667, 0.76751, 0.88304);
  DiscKernel[20] = vec3(0.21666, 0.11602, 0.24577);
  DiscKernel[21] = vec3(0.15696, -0.856, 0.87027);
  DiscKernel[22] = vec3(-0.75821, 0.58363, 0.95682);
  DiscKernel[23] = vec3(0.99284, -0.02904, 0.99327);
  DiscKernel[24] = vec3(-0.22234, -0.57907, 0.62029);
  DiscKernel[25] = vec3(0.55052, -0.66984, 0.86704);
  DiscKernel[26] = vec3(0.46431, 0.28115, 0.5428);
  DiscKernel[27] = vec3(-0.07214, 0.60554, 0.60982);
  vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  vec4 tmpvar_2;
  int l_3;
  vec4 poissonScale_4;
  vec4 sum_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  sum_5 = tmpvar_6;
  float tmpvar_7;
  tmpvar_7 = clamp (abs((((xlv_TEXCOORD0 * 2.0) - 1.0).y * _BlurArea)), 0.0, _BlurSize);
  poissonScale_4 = ((_MainTex_TexelSize.xyxy * vec4(1.0, 1.0, -1.0, -1.0)) * tmpvar_7);
  if ((tmpvar_7 < 0.01)) {
    tmpvar_2 = tmpvar_6;
  } else {
    l_3 = 0;
    for (int l_3 = 0; l_3 < 28; ) {
      vec4 tmpvar_8;
      tmpvar_8 = (tmpvar_1.xyxy + (DiscKernel[l_3].xyxy * poissonScale_4));
      sum_5 = (sum_5 + (texture2D (_MainTex, tmpvar_8.xy) + texture2D (_MainTex, tmpvar_8.zw)));
      l_3 = (l_3 + 1);
    };
    vec4 tmpvar_9;
    tmpvar_9.xyz = (sum_5.xyz / 57.0);
    tmpvar_9.w = tmpvar_7;
    tmpvar_2 = tmpvar_9;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_BlurSize]
Float 2 [_BlurArea]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c4, 0.62462997, 0.54337001, -0.13414000, -0.94488001
def c5, 0.38771999, -0.43474999, 0.12126000, -0.19282000
def c6, -0.20388000, 0.11133000, 0.83113998, -0.29218000
def c7, 0.10759000, -0.57839000, 0.28285000, 0.79035997
def c8, -0.36622000, 0.39515999, 0.75590998, 0.21916001
def c9, -0.52609998, 0.02386000, -0.88216001, -0.24471000
def c10, -0.48888001, -0.29330000, 0.44014001, -0.08558000
def c11, 0.21179000, 0.51372999, 0.05483000, 0.95700997
def c12, -0.59000999, -0.70508999, -0.80065000, 0.24631000
def c13, -0.19424000, -0.18402000, -0.43667001, 0.76751000
def c14, 0.21665999, 0.11602000, 0.15696000, -0.85600001
def c15, -0.75821000, 0.58363003, 0.99283999, -0.02904000
def c16, -0.22234000, -0.57906997, 0.55052000, -0.66983998
def c17, 0.46430999, 0.28115001, -0.07214000, 0.60553998
def c18, 0.01754386, 0, 0, 0
dcl_texcoord0 v0.xy
mad r0.x, v0.y, c3, c3.y
mul r0.x, r0, c2
abs r0.x, r0
min r0.x, r0, c1
max r3.w, r0.x, c3.z
mul r0.xy, r3.w, c0
mul r2, r0.xyxy, c3.wwyy
mad r1, r2, c4.zwzw, v0.xyxy
texld r3.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
mad r0, r2, c4.xyxy, v0.xyxy
add r1.xyz, r1, r3
texld r3.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r3.xyz, r0, r3
texld r0.xyz, v0, s0
add r0.xyz, r0, r3
add r3.xyz, r0, r1
mad r0, r2, c5.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c5.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c6.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c6.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c7.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c7.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c8.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c8.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c9.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c9.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c10.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c10.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c11.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c11.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c12.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c12.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c13.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c13.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c14.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c14.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c15.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c15.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c16.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c16.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r0.xyz, r3, r0
add r1.xyz, r1, r4
add r1.xyz, r0, r1
mad r0, r2, c17.xyxy, v0.xyxy
texld r3.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r3
mad r2, r2, c17.zwzw, v0.xyxy
texld r3.xyz, r2.zwzw, s0
texld r2.xyz, r2, s0
add r2.xyz, r2, r3
add r0.xyz, r1, r0
add r0.xyz, r0, r2
mul oC0.xyz, r0, c18.x
mov oC0.w, r3
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_BlurSize]
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpplmmlmifmkdibdlifmcegocifkengalabaaaaaaimafaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaeaaaaeaaaaaaacnabaaaa
dfbiaaaahcaaaaaamaohbpdpembkaldpebpbfddpaaaaaaaappflajlokiodhblp
eifahedpaaaaaaaadmidmgdoinjhnololacabfdpaaaaaaaackfhpidnjlhceflo
cjdpgjdoaaaaaaaaolmffalopmaaoednanoagndoaaaaaaaajhmffedpjojijflo
dhijgbdpaaaaaaaacffinmdnfobbbelphmjlbgdpaaaaaaaalhnbjadoaiffekdp
dcogfgdpaaaaaaaadaiblllogjfcmkdocnomajdpaaaaaaaafbidebdphlglgado
hehlejdpaaaaaaaahnkoaglpamhgmddmobnbagdpaaaaaaaadnnfgblpecjfhklo
dofmgkdpaaaaaaaahleopkloglcljglollpcbbdpaaaaaaaaaifkobdojbeekpln
bajcofdoaaaaaaaahknpfidompidaddpgeeaaodpaaaaaaaagmjfgadnjlpohedp
iagfhfdpaaaaaaaaofakbhlpmhiadelphnfmgldpaaaaaaaaggphemlpladihmdo
dchcfgdpaaaaaaaankogeglolngpdmlooppoiidoaaaaaaaadgjdnploijhleedp
ojaogcdpaaaaaaaabonmfndoofjlondnccklhldoaaaaaaaabplkcadonbccfllp
aemkfodpaaaaaaaaanbkeclpmhgibfdpcipchedpaaaaaaaamdckhodpelofonlm
pbeghodpaaaaaaaabjkngdlooodnbelpfdmlbodpaaaaaaaaobooamdpkchkcllp
ffpgfndpaaaaaaaaaklkondoofpcipdopbpeakdpaaaaaaaacdlojdlnklaebldp
ckbnbmdpaaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaabkbabaaaabaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaialpdiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaacaaaaaaddaaaaaj
bcaabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaknhcddmbpaaaead
dkaabaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab
bfaaaaabdgaaaaaigcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaialp
aaaaaaaadiaaaaaipcaabaaaacaaaaaafgaabaaaabaaaaaaegiecaaaaaaaaaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaaagakbaaaabaaaaaaegaobaaaacaaaaaa
dgaaaaafocaabaaaabaaaaaaagajbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaadaaaaaadkaabaaaaaaaaaaa
abeaaaaabmaaaaaaadaaaeadakaabaaaadaaaaaadcaaaaakpcaabaaaadaaaaaa
egjejaaadkaabaaaaaaaaaaaegaobaaaacaaaaaaegbebaaaabaaaaaaeiaaaaal
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaiadpeiaaaaalpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaaagajbaaaadaaaaaaboaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaabaaaaaabgaaaaabdiaaaaakhccabaaaaaaaaaaajgahbaaaabaaaaaa
aceaaaaaceliipdmceliipdmceliipdmaaaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaabaaaaaadoaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
uniform float _BlurSize;
uniform float _BlurArea;
vec3 DiscKernel[28];
varying vec2 xlv_TEXCOORD0;
void main ()
{
  DiscKernel[0] = vec3(0.62463, 0.54337, 0.8279);
  DiscKernel[1] = vec3(-0.13414, -0.94488, 0.95435);
  DiscKernel[2] = vec3(0.38772, -0.43475, 0.58253);
  DiscKernel[3] = vec3(0.12126, -0.19282, 0.22778);
  DiscKernel[4] = vec3(-0.20388, 0.11133, 0.2323);
  DiscKernel[5] = vec3(0.83114, -0.29218, 0.881);
  DiscKernel[6] = vec3(0.10759, -0.57839, 0.58831);
  DiscKernel[7] = vec3(0.28285, 0.79036, 0.83945);
  DiscKernel[8] = vec3(-0.36622, 0.39516, 0.53876);
  DiscKernel[9] = vec3(0.75591, 0.21916, 0.78704);
  DiscKernel[10] = vec3(-0.5261, 0.02386, 0.52664);
  DiscKernel[11] = vec3(-0.88216, -0.24471, 0.91547);
  DiscKernel[12] = vec3(-0.48888, -0.2933, 0.57011);
  DiscKernel[13] = vec3(0.44014, -0.08558, 0.44838);
  DiscKernel[14] = vec3(0.21179, 0.51373, 0.55567);
  DiscKernel[15] = vec3(0.05483, 0.95701, 0.95858);
  DiscKernel[16] = vec3(-0.59001, -0.70509, 0.91938);
  DiscKernel[17] = vec3(-0.80065, 0.24631, 0.83768);
  DiscKernel[18] = vec3(-0.19424, -0.18402, 0.26757);
  DiscKernel[19] = vec3(-0.43667, 0.76751, 0.88304);
  DiscKernel[20] = vec3(0.21666, 0.11602, 0.24577);
  DiscKernel[21] = vec3(0.15696, -0.856, 0.87027);
  DiscKernel[22] = vec3(-0.75821, 0.58363, 0.95682);
  DiscKernel[23] = vec3(0.99284, -0.02904, 0.99327);
  DiscKernel[24] = vec3(-0.22234, -0.57907, 0.62029);
  DiscKernel[25] = vec3(0.55052, -0.66984, 0.86704);
  DiscKernel[26] = vec3(0.46431, 0.28115, 0.5428);
  DiscKernel[27] = vec3(-0.07214, 0.60554, 0.60982);
  vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  vec4 tmpvar_2;
  int l_3;
  vec4 poissonScale_4;
  vec4 sum_5;
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  sum_5 = tmpvar_6;
  vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0 * 2.0) - 1.0);
  float tmpvar_8;
  tmpvar_8 = clamp ((dot (tmpvar_7, tmpvar_7) * _BlurArea), 0.0, _BlurSize);
  poissonScale_4 = (vec4(2.0, 2.0, -2.0, -2.0) * _MainTex_TexelSize.xyxy);
  if ((tmpvar_8 < 0.01)) {
    tmpvar_2 = tmpvar_6;
  } else {
    l_3 = 0;
    for (int l_3 = 0; l_3 < 28; ) {
      vec4 tmpvar_9;
      tmpvar_9 = (tmpvar_1.xyxy + (DiscKernel[l_3].xyxy * poissonScale_4));
      sum_5 = (sum_5 + (texture2D (_MainTex, tmpvar_9.xy) + texture2D (_MainTex, tmpvar_9.zw)));
      l_3 = (l_3 + 1);
    };
    vec4 tmpvar_10;
    tmpvar_10.xyz = (sum_5.xyz / 57.0);
    tmpvar_10.w = tmpvar_8;
    tmpvar_2 = tmpvar_10;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
Float 1 [_BlurSize]
Float 2 [_BlurArea]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
def c3, 2.00000000, -2.00000000, 0.62462997, 0.54337001
def c4, -0.13414000, -0.94488001, 0.38771999, -0.43474999
def c5, 0.12126000, -0.19282000, -0.20388000, 0.11133000
def c6, 0.83113998, -0.29218000, 0.10759000, -0.57839000
def c7, 0.28285000, 0.79035997, -0.36622000, 0.39515999
def c8, 0.75590998, 0.21916001, -0.52609998, 0.02386000
def c9, -0.88216001, -0.24471000, -0.48888001, -0.29330000
def c10, 0.44014001, -0.08558000, 0.21179000, 0.51372999
def c11, 0.05483000, 0.95700997, -0.59000999, -0.70508999
def c12, -0.80065000, 0.24631000, -0.19424000, -0.18402000
def c13, -0.43667001, 0.76751000, 0.21665999, 0.11602000
def c14, 0.15696000, -0.85600001, -0.75821000, 0.58363003
def c15, 0.99283999, -0.02904000, -0.22234000, -0.57906997
def c16, 0.55052000, -0.66983998, 0.46430999, 0.28115001
def c17, -0.07214000, 0.60553998, 0.01754386, 0.00000000
def c18, 2.00000000, -1.00000000, 0, 0
dcl_texcoord0 v0.xy
mov r0.xy, c0
mul r2, c3.xxyy, r0.xyxy
mad r0, r2, c4.zwzw, v0.xyxy
texld r1.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r3.xyz, r0, r1
mad r1, r2, c4.xyxy, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
mad r0, r2, c3.zwzw, v0.xyxy
add r1.xyz, r1, r4
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r4.xyz, r0, r4
texld r0.xyz, v0, s0
add r0.xyz, r0, r4
add r0.xyz, r0, r1
add r3.xyz, r0, r3
mad r0, r2, c5.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c5.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c6.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c6.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c7.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c7.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c8.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c8.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c9.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c9.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c10.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c10.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c11.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c11.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c12.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c12.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c13.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c13.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c14.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c14.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c15.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c15.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r3, r0
add r3.xyz, r0, r1
mad r0, r2, c16.xyxy, v0.xyxy
texld r4.xyz, r0.zwzw, s0
texld r0.xyz, r0, s0
add r0.xyz, r0, r4
mad r1, r2, c16.zwzw, v0.xyxy
texld r4.xyz, r1.zwzw, s0
add r0.xyz, r3, r0
texld r1.xyz, r1, s0
add r1.xyz, r1, r4
add r0.xyz, r0, r1
mad r1, r2, c17.xyxy, v0.xyxy
texld r2.xyz, r1, s0
mad r3.xy, v0, c18.x, c18.y
mul r3.xy, r3, r3
texld r1.xyz, r1.zwzw, s0
add r0.w, r3.x, r3.y
add r1.xyz, r2, r1
mul r0.w, r0, c2.x
add r0.xyz, r0, r1
min r0.w, r0, c1.x
mul oC0.xyz, r0, c17.z
max oC0.w, r0, c17
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_BlurSize]
Float 36 [_BlurArea]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmnpliodlglfndobkabbcemohjbedcodaabaaaaaakiafaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaeaaaaeaaaaaaadeabaaaa
dfbiaaaahcaaaaaamaohbpdpembkaldpebpbfddpaaaaaaaappflajlokiodhblp
eifahedpaaaaaaaadmidmgdoinjhnololacabfdpaaaaaaaackfhpidnjlhceflo
cjdpgjdoaaaaaaaaolmffalopmaaoednanoagndoaaaaaaaajhmffedpjojijflo
dhijgbdpaaaaaaaacffinmdnfobbbelphmjlbgdpaaaaaaaalhnbjadoaiffekdp
dcogfgdpaaaaaaaadaiblllogjfcmkdocnomajdpaaaaaaaafbidebdphlglgado
hehlejdpaaaaaaaahnkoaglpamhgmddmobnbagdpaaaaaaaadnnfgblpecjfhklo
dofmgkdpaaaaaaaahleopkloglcljglollpcbbdpaaaaaaaaaifkobdojbeekpln
bajcofdoaaaaaaaahknpfidompidaddpgeeaaodpaaaaaaaagmjfgadnjlpohedp
iagfhfdpaaaaaaaaofakbhlpmhiadelphnfmgldpaaaaaaaaggphemlpladihmdo
dchcfgdpaaaaaaaankogeglolngpdmlooppoiidoaaaaaaaadgjdnploijhleedp
ojaogcdpaaaaaaaabonmfndoofjlondnccklhldoaaaaaaaabplkcadonbccfllp
aemkfodpaaaaaaaaanbkeclpmhgibfdpcipchedpaaaaaaaamdckhodpelofonlm
pbeghodpaaaaaaaabjkngdlooodnbelpfdmlbodpaaaaaaaaobooamdpkchkcllp
ffpgfndpaaaaaaaaaklkondoofpcipdopbpeakdpaaaaaaaacdlojdlnklaebldp
ckbnbmdpaaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaa
abaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaabkiacaaaaaaaaaaaacaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaddaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaacaaaaaadbaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaknhcddmbpaaaeadbkaabaaaabaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadoaaaaabbfaaaaabdiaaaaalpcaabaaaacaaaaaaegiecaaa
aaaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaamaaaaaaamadgaaaaaf
ocaabaaaabaaaaaaagajbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahbcaabaaaadaaaaaadkaabaaaaaaaaaaaabeaaaaa
bmaaaaaaadaaaeadakaabaaaadaaaaaadcaaaaakpcaabaaaadaaaaaaegjejaaa
dkaabaaaaaaaaaaaegaobaaaacaaaaaaegbebaaaabaaaaaaeiaaaaalpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaiadpeiaaaaalpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaa
agajbaaaadaaaaaaboaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
abaaaaaabgaaaaabdiaaaaakhccabaaaaaaaaaaajgahbaaaabaaaaaaaceaaaaa
celiipdmceliipdmceliipdmaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
abaaaaaadoaaaaab"
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
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Blurred;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Blurred, xlv_TEXCOORD1);
  gl_FragData[0] = mix (texture2D (_MainTex, xlv_TEXCOORD0), tmpvar_1, vec4(clamp (tmpvar_1.w, 0.0, 1.0)));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, v1
mov o2.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebdbkhnngchefheacdafeefnbomldohhabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
SetTexture 0 [_Blurred] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xy
texld r1, v0, s1
texld r0, v1, s0
add r2, r0, -r1
mov_sat r0.x, r0.w
mad oC0, r0.x, r2, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_Blurred] 2D 1
SetTexture 1 [_MainTex] 2D 0
"ps_4_0
eefiecedmkmjggjcimgimcaghchjfepkbllbejoiabaaaaaaoiabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaabaaaaeaaaaaaaeeaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadgcaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}