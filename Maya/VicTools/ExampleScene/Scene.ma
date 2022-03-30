//Maya ASCII 2018ff08 scene
//Name: Scene.ma
//Last modified: Mon, Mar 21, 2022 02:59:02 PM
//Codeset: 950
file -rdi 1 -ns "Man" -rfn "ManRN" -op "v=0;" -typ "mayaAscii" "D:/FOD2_Project/ToolSource/Art/VicTools/ExampleScene/Man.ma";
file -r -ns "Man" -dr 1 -rfn "ManRN" -op "v=0;" -typ "mayaAscii" "D:/FOD2_Project/ToolSource/Art/VicTools/ExampleScene/Man.ma";
requires maya "2018ff08";
requires "mtoa" "3.0.0.2";
requires "stereoCamera" "10.0";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2018";
fileInfo "version" "2018";
fileInfo "cutIdentifier" "201804211841-f3d65dda2a";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -s -n "persp";
	rename -uid "A384F779-493E-685B-21A8-DFA03BEC0E28";
	addAttr -ci true -sn "AnimationExportSetting" -ln "AnimationExportSetting" -dt "string";
	setAttr ".v" no;
	setAttr ".t" -type "double3" -87.041404001659771 -196.65550192026382 183.48746780155994 ;
	setAttr ".r" -type "double3" 64.88292491535762 0 -30.805086005254527 ;
	setAttr ".AnimationExportSetting" -type "string" "[{\"start\": \"100\", \"export\": \"1\", \"name\": \":Man\", \"root_type\": \"0\", \"cloth\": \"0\", \"end\": \"150\", \"blend\": \"0\", \"fileName\": \"\"}]";
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "6D429F80-4BA9-E7B0-A09C-269918DF763C";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 269.75300462978726;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".ai_translator" -type "string" "perspective";
createNode transform -s -n "top";
	rename -uid "A55364B3-4EA7-D8A1-B8E4-4DAE893C1B1F";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "D1D7FB9D-45F0-C641-0546-F79096745E39";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "front";
	rename -uid "5EB300E0-4E38-3C18-1C15-8DB84D73003E";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 -1000.1 0 ;
	setAttr ".r" -type "double3" 89.999999999999986 0 0 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "4E9223D4-45E0-5410-2636-2D86FFE809D3";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "side";
	rename -uid "CED354D9-413D-52CE-8A73-5D91A7604A71";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 90 1.2722218725854067e-14 89.999999999999986 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "C811AC86-44D0-C328-28CA-D7AADFC8E72B";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode lightLinker -s -n "lightLinker1";
	rename -uid "223D2C15-415D-3ED8-E717-20A8D2DD1D19";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "DD61A5F8-4398-9865-377E-76B099CDD96A";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "BB1B8ADF-421B-26AF-6283-38ABD007CAF5";
createNode displayLayerManager -n "layerManager";
	rename -uid "7D3DE940-43C6-ACD1-0AF2-A3982D9BCEB8";
createNode displayLayer -n "defaultLayer";
	rename -uid "55E2F6CB-408C-8CC9-4161-B48674DE5515";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "847B7FBE-40D4-1A99-5908-8084DFAFD0BE";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "10651C00-475D-18F5-2A01-278AF6717148";
	setAttr ".g" yes;
createNode reference -n "ManRN";
	rename -uid "0708622C-455C-453A-0455-979905758168";
	setAttr -s 968 ".phl";
	setAttr ".phl[1]" 0;
	setAttr ".phl[2]" 0;
	setAttr ".phl[3]" 0;
	setAttr ".phl[4]" 0;
	setAttr ".phl[5]" 0;
	setAttr ".phl[6]" 0;
	setAttr ".phl[7]" 0;
	setAttr ".phl[8]" 0;
	setAttr ".phl[9]" 0;
	setAttr ".phl[10]" 0;
	setAttr ".phl[11]" 0;
	setAttr ".phl[12]" 0;
	setAttr ".phl[13]" 0;
	setAttr ".phl[14]" 0;
	setAttr ".phl[15]" 0;
	setAttr ".phl[16]" 0;
	setAttr ".phl[17]" 0;
	setAttr ".phl[18]" 0;
	setAttr ".phl[19]" 0;
	setAttr ".phl[20]" 0;
	setAttr ".phl[21]" 0;
	setAttr ".phl[22]" 0;
	setAttr ".phl[23]" 0;
	setAttr ".phl[24]" 0;
	setAttr ".phl[25]" 0;
	setAttr ".phl[26]" 0;
	setAttr ".phl[27]" 0;
	setAttr ".phl[28]" 0;
	setAttr ".phl[29]" 0;
	setAttr ".phl[30]" 0;
	setAttr ".phl[31]" 0;
	setAttr ".phl[32]" 0;
	setAttr ".phl[33]" 0;
	setAttr ".phl[34]" 0;
	setAttr ".phl[35]" 0;
	setAttr ".phl[36]" 0;
	setAttr ".phl[37]" 0;
	setAttr ".phl[38]" 0;
	setAttr ".phl[39]" 0;
	setAttr ".phl[40]" 0;
	setAttr ".phl[41]" 0;
	setAttr ".phl[42]" 0;
	setAttr ".phl[43]" 0;
	setAttr ".phl[44]" 0;
	setAttr ".phl[45]" 0;
	setAttr ".phl[46]" 0;
	setAttr ".phl[47]" 0;
	setAttr ".phl[48]" 0;
	setAttr ".phl[49]" 0;
	setAttr ".phl[50]" 0;
	setAttr ".phl[51]" 0;
	setAttr ".phl[52]" 0;
	setAttr ".phl[53]" 0;
	setAttr ".phl[54]" 0;
	setAttr ".phl[55]" 0;
	setAttr ".phl[56]" 0;
	setAttr ".phl[57]" 0;
	setAttr ".phl[58]" 0;
	setAttr ".phl[59]" 0;
	setAttr ".phl[60]" 0;
	setAttr ".phl[61]" 0;
	setAttr ".phl[62]" 0;
	setAttr ".phl[63]" 0;
	setAttr ".phl[64]" 0;
	setAttr ".phl[65]" 0;
	setAttr ".phl[66]" 0;
	setAttr ".phl[67]" 0;
	setAttr ".phl[68]" 0;
	setAttr ".phl[69]" 0;
	setAttr ".phl[70]" 0;
	setAttr ".phl[71]" 0;
	setAttr ".phl[72]" 0;
	setAttr ".phl[73]" 0;
	setAttr ".phl[74]" 0;
	setAttr ".phl[75]" 0;
	setAttr ".phl[76]" 0;
	setAttr ".phl[77]" 0;
	setAttr ".phl[78]" 0;
	setAttr ".phl[79]" 0;
	setAttr ".phl[80]" 0;
	setAttr ".phl[81]" 0;
	setAttr ".phl[82]" 0;
	setAttr ".phl[83]" 0;
	setAttr ".phl[84]" 0;
	setAttr ".phl[85]" 0;
	setAttr ".phl[86]" 0;
	setAttr ".phl[87]" 0;
	setAttr ".phl[88]" 0;
	setAttr ".phl[89]" 0;
	setAttr ".phl[90]" 0;
	setAttr ".phl[91]" 0;
	setAttr ".phl[92]" 0;
	setAttr ".phl[93]" 0;
	setAttr ".phl[94]" 0;
	setAttr ".phl[95]" 0;
	setAttr ".phl[96]" 0;
	setAttr ".phl[97]" 0;
	setAttr ".phl[98]" 0;
	setAttr ".phl[99]" 0;
	setAttr ".phl[100]" 0;
	setAttr ".phl[101]" 0;
	setAttr ".phl[102]" 0;
	setAttr ".phl[103]" 0;
	setAttr ".phl[104]" 0;
	setAttr ".phl[105]" 0;
	setAttr ".phl[106]" 0;
	setAttr ".phl[107]" 0;
	setAttr ".phl[108]" 0;
	setAttr ".phl[109]" 0;
	setAttr ".phl[110]" 0;
	setAttr ".phl[111]" 0;
	setAttr ".phl[112]" 0;
	setAttr ".phl[113]" 0;
	setAttr ".phl[114]" 0;
	setAttr ".phl[115]" 0;
	setAttr ".phl[116]" 0;
	setAttr ".phl[117]" 0;
	setAttr ".phl[118]" 0;
	setAttr ".phl[119]" 0;
	setAttr ".phl[120]" 0;
	setAttr ".phl[121]" 0;
	setAttr ".phl[122]" 0;
	setAttr ".phl[123]" 0;
	setAttr ".phl[124]" 0;
	setAttr ".phl[125]" 0;
	setAttr ".phl[126]" 0;
	setAttr ".phl[127]" 0;
	setAttr ".phl[128]" 0;
	setAttr ".phl[129]" 0;
	setAttr ".phl[130]" 0;
	setAttr ".phl[131]" 0;
	setAttr ".phl[132]" 0;
	setAttr ".phl[133]" 0;
	setAttr ".phl[134]" 0;
	setAttr ".phl[135]" 0;
	setAttr ".phl[136]" 0;
	setAttr ".phl[137]" 0;
	setAttr ".phl[138]" 0;
	setAttr ".phl[139]" 0;
	setAttr ".phl[140]" 0;
	setAttr ".phl[141]" 0;
	setAttr ".phl[142]" 0;
	setAttr ".phl[143]" 0;
	setAttr ".phl[144]" 0;
	setAttr ".phl[145]" 0;
	setAttr ".phl[146]" 0;
	setAttr ".phl[147]" 0;
	setAttr ".phl[148]" 0;
	setAttr ".phl[149]" 0;
	setAttr ".phl[150]" 0;
	setAttr ".phl[151]" 0;
	setAttr ".phl[152]" 0;
	setAttr ".phl[153]" 0;
	setAttr ".phl[154]" 0;
	setAttr ".phl[155]" 0;
	setAttr ".phl[156]" 0;
	setAttr ".phl[157]" 0;
	setAttr ".phl[158]" 0;
	setAttr ".phl[159]" 0;
	setAttr ".phl[160]" 0;
	setAttr ".phl[161]" 0;
	setAttr ".phl[162]" 0;
	setAttr ".phl[163]" 0;
	setAttr ".phl[164]" 0;
	setAttr ".phl[165]" 0;
	setAttr ".phl[166]" 0;
	setAttr ".phl[167]" 0;
	setAttr ".phl[168]" 0;
	setAttr ".phl[169]" 0;
	setAttr ".phl[170]" 0;
	setAttr ".phl[171]" 0;
	setAttr ".phl[172]" 0;
	setAttr ".phl[173]" 0;
	setAttr ".phl[174]" 0;
	setAttr ".phl[175]" 0;
	setAttr ".phl[176]" 0;
	setAttr ".phl[177]" 0;
	setAttr ".phl[178]" 0;
	setAttr ".phl[179]" 0;
	setAttr ".phl[180]" 0;
	setAttr ".phl[181]" 0;
	setAttr ".phl[182]" 0;
	setAttr ".phl[183]" 0;
	setAttr ".phl[184]" 0;
	setAttr ".phl[185]" 0;
	setAttr ".phl[186]" 0;
	setAttr ".phl[187]" 0;
	setAttr ".phl[188]" 0;
	setAttr ".phl[189]" 0;
	setAttr ".phl[190]" 0;
	setAttr ".phl[191]" 0;
	setAttr ".phl[192]" 0;
	setAttr ".phl[193]" 0;
	setAttr ".phl[194]" 0;
	setAttr ".phl[195]" 0;
	setAttr ".phl[196]" 0;
	setAttr ".phl[197]" 0;
	setAttr ".phl[198]" 0;
	setAttr ".phl[199]" 0;
	setAttr ".phl[200]" 0;
	setAttr ".phl[201]" 0;
	setAttr ".phl[202]" 0;
	setAttr ".phl[203]" 0;
	setAttr ".phl[204]" 0;
	setAttr ".phl[205]" 0;
	setAttr ".phl[206]" 0;
	setAttr ".phl[207]" 0;
	setAttr ".phl[208]" 0;
	setAttr ".phl[209]" 0;
	setAttr ".phl[210]" 0;
	setAttr ".phl[211]" 0;
	setAttr ".phl[212]" 0;
	setAttr ".phl[213]" 0;
	setAttr ".phl[214]" 0;
	setAttr ".phl[215]" 0;
	setAttr ".phl[216]" 0;
	setAttr ".phl[217]" 0;
	setAttr ".phl[218]" 0;
	setAttr ".phl[219]" 0;
	setAttr ".phl[220]" 0;
	setAttr ".phl[221]" 0;
	setAttr ".phl[222]" 0;
	setAttr ".phl[223]" 0;
	setAttr ".phl[224]" 0;
	setAttr ".phl[225]" 0;
	setAttr ".phl[226]" 0;
	setAttr ".phl[227]" 0;
	setAttr ".phl[228]" 0;
	setAttr ".phl[229]" 0;
	setAttr ".phl[230]" 0;
	setAttr ".phl[231]" 0;
	setAttr ".phl[232]" 0;
	setAttr ".phl[233]" 0;
	setAttr ".phl[234]" 0;
	setAttr ".phl[235]" 0;
	setAttr ".phl[236]" 0;
	setAttr ".phl[237]" 0;
	setAttr ".phl[238]" 0;
	setAttr ".phl[239]" 0;
	setAttr ".phl[240]" 0;
	setAttr ".phl[241]" 0;
	setAttr ".phl[242]" 0;
	setAttr ".phl[243]" 0;
	setAttr ".phl[244]" 0;
	setAttr ".phl[245]" 0;
	setAttr ".phl[246]" 0;
	setAttr ".phl[247]" 0;
	setAttr ".phl[248]" 0;
	setAttr ".phl[249]" 0;
	setAttr ".phl[250]" 0;
	setAttr ".phl[251]" 0;
	setAttr ".phl[252]" 0;
	setAttr ".phl[253]" 0;
	setAttr ".phl[254]" 0;
	setAttr ".phl[255]" 0;
	setAttr ".phl[256]" 0;
	setAttr ".phl[257]" 0;
	setAttr ".phl[258]" 0;
	setAttr ".phl[259]" 0;
	setAttr ".phl[260]" 0;
	setAttr ".phl[261]" 0;
	setAttr ".phl[262]" 0;
	setAttr ".phl[263]" 0;
	setAttr ".phl[264]" 0;
	setAttr ".phl[265]" 0;
	setAttr ".phl[266]" 0;
	setAttr ".phl[267]" 0;
	setAttr ".phl[268]" 0;
	setAttr ".phl[269]" 0;
	setAttr ".phl[270]" 0;
	setAttr ".phl[271]" 0;
	setAttr ".phl[272]" 0;
	setAttr ".phl[273]" 0;
	setAttr ".phl[274]" 0;
	setAttr ".phl[275]" 0;
	setAttr ".phl[276]" 0;
	setAttr ".phl[277]" 0;
	setAttr ".phl[278]" 0;
	setAttr ".phl[279]" 0;
	setAttr ".phl[280]" 0;
	setAttr ".phl[281]" 0;
	setAttr ".phl[282]" 0;
	setAttr ".phl[283]" 0;
	setAttr ".phl[284]" 0;
	setAttr ".phl[285]" 0;
	setAttr ".phl[286]" 0;
	setAttr ".phl[287]" 0;
	setAttr ".phl[288]" 0;
	setAttr ".phl[289]" 0;
	setAttr ".phl[290]" 0;
	setAttr ".phl[291]" 0;
	setAttr ".phl[292]" 0;
	setAttr ".phl[293]" 0;
	setAttr ".phl[294]" 0;
	setAttr ".phl[295]" 0;
	setAttr ".phl[296]" 0;
	setAttr ".phl[297]" 0;
	setAttr ".phl[298]" 0;
	setAttr ".phl[299]" 0;
	setAttr ".phl[300]" 0;
	setAttr ".phl[301]" 0;
	setAttr ".phl[302]" 0;
	setAttr ".phl[303]" 0;
	setAttr ".phl[304]" 0;
	setAttr ".phl[305]" 0;
	setAttr ".phl[306]" 0;
	setAttr ".phl[307]" 0;
	setAttr ".phl[308]" 0;
	setAttr ".phl[309]" 0;
	setAttr ".phl[310]" 0;
	setAttr ".phl[311]" 0;
	setAttr ".phl[312]" 0;
	setAttr ".phl[313]" 0;
	setAttr ".phl[314]" 0;
	setAttr ".phl[315]" 0;
	setAttr ".phl[316]" 0;
	setAttr ".phl[317]" 0;
	setAttr ".phl[318]" 0;
	setAttr ".phl[319]" 0;
	setAttr ".phl[320]" 0;
	setAttr ".phl[321]" 0;
	setAttr ".phl[322]" 0;
	setAttr ".phl[323]" 0;
	setAttr ".phl[324]" 0;
	setAttr ".phl[325]" 0;
	setAttr ".phl[326]" 0;
	setAttr ".phl[327]" 0;
	setAttr ".phl[328]" 0;
	setAttr ".phl[329]" 0;
	setAttr ".phl[330]" 0;
	setAttr ".phl[331]" 0;
	setAttr ".phl[332]" 0;
	setAttr ".phl[333]" 0;
	setAttr ".phl[334]" 0;
	setAttr ".phl[335]" 0;
	setAttr ".phl[336]" 0;
	setAttr ".phl[337]" 0;
	setAttr ".phl[338]" 0;
	setAttr ".phl[339]" 0;
	setAttr ".phl[340]" 0;
	setAttr ".phl[341]" 0;
	setAttr ".phl[342]" 0;
	setAttr ".phl[343]" 0;
	setAttr ".phl[344]" 0;
	setAttr ".phl[345]" 0;
	setAttr ".phl[346]" 0;
	setAttr ".phl[347]" 0;
	setAttr ".phl[348]" 0;
	setAttr ".phl[349]" 0;
	setAttr ".phl[350]" 0;
	setAttr ".phl[351]" 0;
	setAttr ".phl[352]" 0;
	setAttr ".phl[353]" 0;
	setAttr ".phl[354]" 0;
	setAttr ".phl[355]" 0;
	setAttr ".phl[356]" 0;
	setAttr ".phl[357]" 0;
	setAttr ".phl[358]" 0;
	setAttr ".phl[359]" 0;
	setAttr ".phl[360]" 0;
	setAttr ".phl[361]" 0;
	setAttr ".phl[362]" 0;
	setAttr ".phl[363]" 0;
	setAttr ".phl[364]" 0;
	setAttr ".phl[365]" 0;
	setAttr ".phl[366]" 0;
	setAttr ".phl[367]" 0;
	setAttr ".phl[368]" 0;
	setAttr ".phl[369]" 0;
	setAttr ".phl[370]" 0;
	setAttr ".phl[371]" 0;
	setAttr ".phl[372]" 0;
	setAttr ".phl[373]" 0;
	setAttr ".phl[374]" 0;
	setAttr ".phl[375]" 0;
	setAttr ".phl[376]" 0;
	setAttr ".phl[377]" 0;
	setAttr ".phl[378]" 0;
	setAttr ".phl[379]" 0;
	setAttr ".phl[380]" 0;
	setAttr ".phl[381]" 0;
	setAttr ".phl[382]" 0;
	setAttr ".phl[383]" 0;
	setAttr ".phl[384]" 0;
	setAttr ".phl[385]" 0;
	setAttr ".phl[386]" 0;
	setAttr ".phl[387]" 0;
	setAttr ".phl[388]" 0;
	setAttr ".phl[389]" 0;
	setAttr ".phl[390]" 0;
	setAttr ".phl[391]" 0;
	setAttr ".phl[392]" 0;
	setAttr ".phl[393]" 0;
	setAttr ".phl[394]" 0;
	setAttr ".phl[395]" 0;
	setAttr ".phl[396]" 0;
	setAttr ".phl[397]" 0;
	setAttr ".phl[398]" 0;
	setAttr ".phl[399]" 0;
	setAttr ".phl[400]" 0;
	setAttr ".phl[401]" 0;
	setAttr ".phl[402]" 0;
	setAttr ".phl[403]" 0;
	setAttr ".phl[404]" 0;
	setAttr ".phl[405]" 0;
	setAttr ".phl[406]" 0;
	setAttr ".phl[407]" 0;
	setAttr ".phl[408]" 0;
	setAttr ".phl[409]" 0;
	setAttr ".phl[410]" 0;
	setAttr ".phl[411]" 0;
	setAttr ".phl[412]" 0;
	setAttr ".phl[413]" 0;
	setAttr ".phl[414]" 0;
	setAttr ".phl[415]" 0;
	setAttr ".phl[416]" 0;
	setAttr ".phl[417]" 0;
	setAttr ".phl[418]" 0;
	setAttr ".phl[419]" 0;
	setAttr ".phl[420]" 0;
	setAttr ".phl[421]" 0;
	setAttr ".phl[422]" 0;
	setAttr ".phl[423]" 0;
	setAttr ".phl[424]" 0;
	setAttr ".phl[425]" 0;
	setAttr ".phl[426]" 0;
	setAttr ".phl[427]" 0;
	setAttr ".phl[428]" 0;
	setAttr ".phl[429]" 0;
	setAttr ".phl[430]" 0;
	setAttr ".phl[431]" 0;
	setAttr ".phl[432]" 0;
	setAttr ".phl[433]" 0;
	setAttr ".phl[434]" 0;
	setAttr ".phl[435]" 0;
	setAttr ".phl[436]" 0;
	setAttr ".phl[437]" 0;
	setAttr ".phl[438]" 0;
	setAttr ".phl[439]" 0;
	setAttr ".phl[440]" 0;
	setAttr ".phl[441]" 0;
	setAttr ".phl[442]" 0;
	setAttr ".phl[443]" 0;
	setAttr ".phl[444]" 0;
	setAttr ".phl[445]" 0;
	setAttr ".phl[446]" 0;
	setAttr ".phl[447]" 0;
	setAttr ".phl[448]" 0;
	setAttr ".phl[449]" 0;
	setAttr ".phl[450]" 0;
	setAttr ".phl[451]" 0;
	setAttr ".phl[452]" 0;
	setAttr ".phl[453]" 0;
	setAttr ".phl[454]" 0;
	setAttr ".phl[455]" 0;
	setAttr ".phl[456]" 0;
	setAttr ".phl[457]" 0;
	setAttr ".phl[458]" 0;
	setAttr ".phl[459]" 0;
	setAttr ".phl[460]" 0;
	setAttr ".phl[461]" 0;
	setAttr ".phl[462]" 0;
	setAttr ".phl[463]" 0;
	setAttr ".phl[464]" 0;
	setAttr ".phl[465]" 0;
	setAttr ".phl[466]" 0;
	setAttr ".phl[467]" 0;
	setAttr ".phl[468]" 0;
	setAttr ".phl[469]" 0;
	setAttr ".phl[470]" 0;
	setAttr ".phl[471]" 0;
	setAttr ".phl[472]" 0;
	setAttr ".phl[473]" 0;
	setAttr ".phl[474]" 0;
	setAttr ".phl[475]" 0;
	setAttr ".phl[476]" 0;
	setAttr ".phl[477]" 0;
	setAttr ".phl[478]" 0;
	setAttr ".phl[479]" 0;
	setAttr ".phl[480]" 0;
	setAttr ".phl[481]" 0;
	setAttr ".phl[482]" 0;
	setAttr ".phl[483]" 0;
	setAttr ".phl[484]" 0;
	setAttr ".phl[485]" 0;
	setAttr ".phl[486]" 0;
	setAttr ".phl[487]" 0;
	setAttr ".phl[488]" 0;
	setAttr ".phl[489]" 0;
	setAttr ".phl[490]" 0;
	setAttr ".phl[491]" 0;
	setAttr ".phl[492]" 0;
	setAttr ".phl[493]" 0;
	setAttr ".phl[494]" 0;
	setAttr ".phl[495]" 0;
	setAttr ".phl[496]" 0;
	setAttr ".phl[497]" 0;
	setAttr ".phl[498]" 0;
	setAttr ".phl[499]" 0;
	setAttr ".phl[500]" 0;
	setAttr ".phl[501]" 0;
	setAttr ".phl[502]" 0;
	setAttr ".phl[503]" 0;
	setAttr ".phl[504]" 0;
	setAttr ".phl[505]" 0;
	setAttr ".phl[506]" 0;
	setAttr ".phl[507]" 0;
	setAttr ".phl[508]" 0;
	setAttr ".phl[509]" 0;
	setAttr ".phl[510]" 0;
	setAttr ".phl[511]" 0;
	setAttr ".phl[512]" 0;
	setAttr ".phl[513]" 0;
	setAttr ".phl[514]" 0;
	setAttr ".phl[515]" 0;
	setAttr ".phl[516]" 0;
	setAttr ".phl[517]" 0;
	setAttr ".phl[518]" 0;
	setAttr ".phl[519]" 0;
	setAttr ".phl[520]" 0;
	setAttr ".phl[521]" 0;
	setAttr ".phl[522]" 0;
	setAttr ".phl[523]" 0;
	setAttr ".phl[524]" 0;
	setAttr ".phl[525]" 0;
	setAttr ".phl[526]" 0;
	setAttr ".phl[527]" 0;
	setAttr ".phl[528]" 0;
	setAttr ".phl[529]" 0;
	setAttr ".phl[530]" 0;
	setAttr ".phl[531]" 0;
	setAttr ".phl[532]" 0;
	setAttr ".phl[533]" 0;
	setAttr ".phl[534]" 0;
	setAttr ".phl[535]" 0;
	setAttr ".phl[536]" 0;
	setAttr ".phl[537]" 0;
	setAttr ".phl[538]" 0;
	setAttr ".phl[539]" 0;
	setAttr ".phl[540]" 0;
	setAttr ".phl[541]" 0;
	setAttr ".phl[542]" 0;
	setAttr ".phl[543]" 0;
	setAttr ".phl[544]" 0;
	setAttr ".phl[545]" 0;
	setAttr ".phl[546]" 0;
	setAttr ".phl[547]" 0;
	setAttr ".phl[548]" 0;
	setAttr ".phl[549]" 0;
	setAttr ".phl[550]" 0;
	setAttr ".phl[551]" 0;
	setAttr ".phl[552]" 0;
	setAttr ".phl[553]" 0;
	setAttr ".phl[554]" 0;
	setAttr ".phl[555]" 0;
	setAttr ".phl[556]" 0;
	setAttr ".phl[557]" 0;
	setAttr ".phl[558]" 0;
	setAttr ".phl[559]" 0;
	setAttr ".phl[560]" 0;
	setAttr ".phl[561]" 0;
	setAttr ".phl[562]" 0;
	setAttr ".phl[563]" 0;
	setAttr ".phl[564]" 0;
	setAttr ".phl[565]" 0;
	setAttr ".phl[566]" 0;
	setAttr ".phl[567]" 0;
	setAttr ".phl[568]" 0;
	setAttr ".phl[569]" 0;
	setAttr ".phl[570]" 0;
	setAttr ".phl[571]" 0;
	setAttr ".phl[572]" 0;
	setAttr ".phl[573]" 0;
	setAttr ".phl[574]" 0;
	setAttr ".phl[575]" 0;
	setAttr ".phl[576]" 0;
	setAttr ".phl[577]" 0;
	setAttr ".phl[578]" 0;
	setAttr ".phl[579]" 0;
	setAttr ".phl[580]" 0;
	setAttr ".phl[581]" 0;
	setAttr ".phl[582]" 0;
	setAttr ".phl[583]" 0;
	setAttr ".phl[584]" 0;
	setAttr ".phl[585]" 0;
	setAttr ".phl[586]" 0;
	setAttr ".phl[587]" 0;
	setAttr ".phl[588]" 0;
	setAttr ".phl[589]" 0;
	setAttr ".phl[590]" 0;
	setAttr ".phl[591]" 0;
	setAttr ".phl[592]" 0;
	setAttr ".phl[593]" 0;
	setAttr ".phl[594]" 0;
	setAttr ".phl[595]" 0;
	setAttr ".phl[596]" 0;
	setAttr ".phl[597]" 0;
	setAttr ".phl[598]" 0;
	setAttr ".phl[599]" 0;
	setAttr ".phl[600]" 0;
	setAttr ".phl[601]" 0;
	setAttr ".phl[602]" 0;
	setAttr ".phl[603]" 0;
	setAttr ".phl[604]" 0;
	setAttr ".phl[605]" 0;
	setAttr ".phl[606]" 0;
	setAttr ".phl[607]" 0;
	setAttr ".phl[608]" 0;
	setAttr ".phl[609]" 0;
	setAttr ".phl[610]" 0;
	setAttr ".phl[611]" 0;
	setAttr ".phl[612]" 0;
	setAttr ".phl[613]" 0;
	setAttr ".phl[614]" 0;
	setAttr ".phl[615]" 0;
	setAttr ".phl[616]" 0;
	setAttr ".phl[617]" 0;
	setAttr ".phl[618]" 0;
	setAttr ".phl[619]" 0;
	setAttr ".phl[620]" 0;
	setAttr ".phl[621]" 0;
	setAttr ".phl[622]" 0;
	setAttr ".phl[623]" 0;
	setAttr ".phl[624]" 0;
	setAttr ".phl[625]" 0;
	setAttr ".phl[626]" 0;
	setAttr ".phl[627]" 0;
	setAttr ".phl[628]" 0;
	setAttr ".phl[629]" 0;
	setAttr ".phl[630]" 0;
	setAttr ".phl[631]" 0;
	setAttr ".phl[632]" 0;
	setAttr ".phl[633]" 0;
	setAttr ".phl[634]" 0;
	setAttr ".phl[635]" 0;
	setAttr ".phl[636]" 0;
	setAttr ".phl[637]" 0;
	setAttr ".phl[638]" 0;
	setAttr ".phl[639]" 0;
	setAttr ".phl[640]" 0;
	setAttr ".phl[641]" 0;
	setAttr ".phl[642]" 0;
	setAttr ".phl[643]" 0;
	setAttr ".phl[644]" 0;
	setAttr ".phl[645]" 0;
	setAttr ".phl[646]" 0;
	setAttr ".phl[647]" 0;
	setAttr ".phl[648]" 0;
	setAttr ".phl[649]" 0;
	setAttr ".phl[650]" 0;
	setAttr ".phl[651]" 0;
	setAttr ".phl[652]" 0;
	setAttr ".phl[653]" 0;
	setAttr ".phl[654]" 0;
	setAttr ".phl[655]" 0;
	setAttr ".phl[656]" 0;
	setAttr ".phl[657]" 0;
	setAttr ".phl[658]" 0;
	setAttr ".phl[659]" 0;
	setAttr ".phl[660]" 0;
	setAttr ".phl[661]" 0;
	setAttr ".phl[662]" 0;
	setAttr ".phl[663]" 0;
	setAttr ".phl[664]" 0;
	setAttr ".phl[665]" 0;
	setAttr ".phl[666]" 0;
	setAttr ".phl[667]" 0;
	setAttr ".phl[668]" 0;
	setAttr ".phl[669]" 0;
	setAttr ".phl[670]" 0;
	setAttr ".phl[671]" 0;
	setAttr ".phl[672]" 0;
	setAttr ".phl[673]" 0;
	setAttr ".phl[674]" 0;
	setAttr ".phl[675]" 0;
	setAttr ".phl[676]" 0;
	setAttr ".phl[677]" 0;
	setAttr ".phl[678]" 0;
	setAttr ".phl[679]" 0;
	setAttr ".phl[680]" 0;
	setAttr ".phl[681]" 0;
	setAttr ".phl[682]" 0;
	setAttr ".phl[683]" 0;
	setAttr ".phl[684]" 0;
	setAttr ".phl[685]" 0;
	setAttr ".phl[686]" 0;
	setAttr ".phl[687]" 0;
	setAttr ".phl[688]" 0;
	setAttr ".phl[689]" 0;
	setAttr ".phl[690]" 0;
	setAttr ".phl[691]" 0;
	setAttr ".phl[692]" 0;
	setAttr ".phl[693]" 0;
	setAttr ".phl[694]" 0;
	setAttr ".phl[695]" 0;
	setAttr ".phl[696]" 0;
	setAttr ".phl[697]" 0;
	setAttr ".phl[698]" 0;
	setAttr ".phl[699]" 0;
	setAttr ".phl[700]" 0;
	setAttr ".phl[701]" 0;
	setAttr ".phl[702]" 0;
	setAttr ".phl[703]" 0;
	setAttr ".phl[704]" 0;
	setAttr ".phl[705]" 0;
	setAttr ".phl[706]" 0;
	setAttr ".phl[707]" 0;
	setAttr ".phl[708]" 0;
	setAttr ".phl[709]" 0;
	setAttr ".phl[710]" 0;
	setAttr ".phl[711]" 0;
	setAttr ".phl[712]" 0;
	setAttr ".phl[713]" 0;
	setAttr ".phl[714]" 0;
	setAttr ".phl[715]" 0;
	setAttr ".phl[716]" 0;
	setAttr ".phl[717]" 0;
	setAttr ".phl[718]" 0;
	setAttr ".phl[719]" 0;
	setAttr ".phl[720]" 0;
	setAttr ".phl[721]" 0;
	setAttr ".phl[722]" 0;
	setAttr ".phl[723]" 0;
	setAttr ".phl[724]" 0;
	setAttr ".phl[725]" 0;
	setAttr ".phl[726]" 0;
	setAttr ".phl[727]" 0;
	setAttr ".phl[728]" 0;
	setAttr ".phl[729]" 0;
	setAttr ".phl[730]" 0;
	setAttr ".phl[731]" 0;
	setAttr ".phl[732]" 0;
	setAttr ".phl[733]" 0;
	setAttr ".phl[734]" 0;
	setAttr ".phl[735]" 0;
	setAttr ".phl[736]" 0;
	setAttr ".phl[737]" 0;
	setAttr ".phl[738]" 0;
	setAttr ".phl[739]" 0;
	setAttr ".phl[740]" 0;
	setAttr ".phl[741]" 0;
	setAttr ".phl[742]" 0;
	setAttr ".phl[743]" 0;
	setAttr ".phl[744]" 0;
	setAttr ".phl[745]" 0;
	setAttr ".phl[746]" 0;
	setAttr ".phl[747]" 0;
	setAttr ".phl[748]" 0;
	setAttr ".phl[749]" 0;
	setAttr ".phl[750]" 0;
	setAttr ".phl[751]" 0;
	setAttr ".phl[752]" 0;
	setAttr ".phl[753]" 0;
	setAttr ".phl[754]" 0;
	setAttr ".phl[755]" 0;
	setAttr ".phl[756]" 0;
	setAttr ".phl[757]" 0;
	setAttr ".phl[758]" 0;
	setAttr ".phl[759]" 0;
	setAttr ".phl[760]" 0;
	setAttr ".phl[761]" 0;
	setAttr ".phl[762]" 0;
	setAttr ".phl[763]" 0;
	setAttr ".phl[764]" 0;
	setAttr ".phl[765]" 0;
	setAttr ".phl[766]" 0;
	setAttr ".phl[767]" 0;
	setAttr ".phl[768]" 0;
	setAttr ".phl[769]" 0;
	setAttr ".phl[770]" 0;
	setAttr ".phl[771]" 0;
	setAttr ".phl[772]" 0;
	setAttr ".phl[773]" 0;
	setAttr ".phl[774]" 0;
	setAttr ".phl[775]" 0;
	setAttr ".phl[776]" 0;
	setAttr ".phl[777]" 0;
	setAttr ".phl[778]" 0;
	setAttr ".phl[779]" 0;
	setAttr ".phl[780]" 0;
	setAttr ".phl[781]" 0;
	setAttr ".phl[782]" 0;
	setAttr ".phl[783]" 0;
	setAttr ".phl[784]" 0;
	setAttr ".phl[785]" 0;
	setAttr ".phl[786]" 0;
	setAttr ".phl[787]" 0;
	setAttr ".phl[788]" 0;
	setAttr ".phl[789]" 0;
	setAttr ".phl[790]" 0;
	setAttr ".phl[791]" 0;
	setAttr ".phl[792]" 0;
	setAttr ".phl[793]" 0;
	setAttr ".phl[794]" 0;
	setAttr ".phl[795]" 0;
	setAttr ".phl[796]" 0;
	setAttr ".phl[797]" 0;
	setAttr ".phl[798]" 0;
	setAttr ".phl[799]" 0;
	setAttr ".phl[800]" 0;
	setAttr ".phl[801]" 0;
	setAttr ".phl[802]" 0;
	setAttr ".phl[803]" 0;
	setAttr ".phl[804]" 0;
	setAttr ".phl[805]" 0;
	setAttr ".phl[806]" 0;
	setAttr ".phl[807]" 0;
	setAttr ".phl[808]" 0;
	setAttr ".phl[809]" 0;
	setAttr ".phl[810]" 0;
	setAttr ".phl[811]" 0;
	setAttr ".phl[812]" 0;
	setAttr ".phl[813]" 0;
	setAttr ".phl[814]" 0;
	setAttr ".phl[815]" 0;
	setAttr ".phl[816]" 0;
	setAttr ".phl[817]" 0;
	setAttr ".phl[818]" 0;
	setAttr ".phl[819]" 0;
	setAttr ".phl[820]" 0;
	setAttr ".phl[821]" 0;
	setAttr ".phl[822]" 0;
	setAttr ".phl[823]" 0;
	setAttr ".phl[824]" 0;
	setAttr ".phl[825]" 0;
	setAttr ".phl[826]" 0;
	setAttr ".phl[827]" 0;
	setAttr ".phl[828]" 0;
	setAttr ".phl[829]" 0;
	setAttr ".phl[830]" 0;
	setAttr ".phl[831]" 0;
	setAttr ".phl[832]" 0;
	setAttr ".phl[833]" 0;
	setAttr ".phl[834]" 0;
	setAttr ".phl[835]" 0;
	setAttr ".phl[836]" 0;
	setAttr ".phl[837]" 0;
	setAttr ".phl[838]" 0;
	setAttr ".phl[839]" 0;
	setAttr ".phl[840]" 0;
	setAttr ".phl[841]" 0;
	setAttr ".phl[842]" 0;
	setAttr ".phl[843]" 0;
	setAttr ".phl[844]" 0;
	setAttr ".phl[845]" 0;
	setAttr ".phl[846]" 0;
	setAttr ".phl[847]" 0;
	setAttr ".phl[848]" 0;
	setAttr ".phl[849]" 0;
	setAttr ".phl[850]" 0;
	setAttr ".phl[851]" 0;
	setAttr ".phl[852]" 0;
	setAttr ".phl[853]" 0;
	setAttr ".phl[854]" 0;
	setAttr ".phl[855]" 0;
	setAttr ".phl[856]" 0;
	setAttr ".phl[857]" 0;
	setAttr ".phl[858]" 0;
	setAttr ".phl[859]" 0;
	setAttr ".phl[860]" 0;
	setAttr ".phl[861]" 0;
	setAttr ".phl[862]" 0;
	setAttr ".phl[863]" 0;
	setAttr ".phl[864]" 0;
	setAttr ".phl[865]" 0;
	setAttr ".phl[866]" 0;
	setAttr ".phl[867]" 0;
	setAttr ".phl[868]" 0;
	setAttr ".phl[869]" 0;
	setAttr ".phl[870]" 0;
	setAttr ".phl[871]" 0;
	setAttr ".phl[872]" 0;
	setAttr ".phl[873]" 0;
	setAttr ".phl[874]" 0;
	setAttr ".phl[875]" 0;
	setAttr ".phl[876]" 0;
	setAttr ".phl[877]" 0;
	setAttr ".phl[878]" 0;
	setAttr ".phl[879]" 0;
	setAttr ".phl[880]" 0;
	setAttr ".phl[881]" 0;
	setAttr ".phl[882]" 0;
	setAttr ".phl[883]" 0;
	setAttr ".phl[884]" 0;
	setAttr ".phl[885]" 0;
	setAttr ".phl[886]" 0;
	setAttr ".phl[887]" 0;
	setAttr ".phl[888]" 0;
	setAttr ".phl[889]" 0;
	setAttr ".phl[890]" 0;
	setAttr ".phl[891]" 0;
	setAttr ".phl[892]" 0;
	setAttr ".phl[893]" 0;
	setAttr ".phl[894]" 0;
	setAttr ".phl[895]" 0;
	setAttr ".phl[896]" 0;
	setAttr ".phl[897]" 0;
	setAttr ".phl[898]" 0;
	setAttr ".phl[899]" 0;
	setAttr ".phl[900]" 0;
	setAttr ".phl[901]" 0;
	setAttr ".phl[902]" 0;
	setAttr ".phl[903]" 0;
	setAttr ".phl[904]" 0;
	setAttr ".phl[905]" 0;
	setAttr ".phl[906]" 0;
	setAttr ".phl[907]" 0;
	setAttr ".phl[908]" 0;
	setAttr ".phl[909]" 0;
	setAttr ".phl[910]" 0;
	setAttr ".phl[911]" 0;
	setAttr ".phl[912]" 0;
	setAttr ".phl[913]" 0;
	setAttr ".phl[914]" 0;
	setAttr ".phl[915]" 0;
	setAttr ".phl[916]" 0;
	setAttr ".phl[917]" 0;
	setAttr ".phl[918]" 0;
	setAttr ".phl[919]" 0;
	setAttr ".phl[920]" 0;
	setAttr ".phl[921]" 0;
	setAttr ".phl[922]" 0;
	setAttr ".phl[923]" 0;
	setAttr ".phl[924]" 0;
	setAttr ".phl[925]" 0;
	setAttr ".phl[926]" 0;
	setAttr ".phl[927]" 0;
	setAttr ".phl[928]" 0;
	setAttr ".phl[929]" 0;
	setAttr ".phl[930]" 0;
	setAttr ".phl[931]" 0;
	setAttr ".phl[932]" 0;
	setAttr ".phl[933]" 0;
	setAttr ".phl[934]" 0;
	setAttr ".phl[935]" 0;
	setAttr ".phl[936]" 0;
	setAttr ".phl[937]" 0;
	setAttr ".phl[938]" 0;
	setAttr ".phl[939]" 0;
	setAttr ".phl[940]" 0;
	setAttr ".phl[941]" 0;
	setAttr ".phl[942]" 0;
	setAttr ".phl[943]" 0;
	setAttr ".phl[944]" 0;
	setAttr ".phl[945]" 0;
	setAttr ".phl[946]" 0;
	setAttr ".phl[947]" 0;
	setAttr ".phl[948]" 0;
	setAttr ".phl[949]" 0;
	setAttr ".phl[950]" 0;
	setAttr ".phl[951]" 0;
	setAttr ".phl[952]" 0;
	setAttr ".phl[953]" 0;
	setAttr ".phl[954]" 0;
	setAttr ".phl[955]" 0;
	setAttr ".phl[956]" 0;
	setAttr ".phl[957]" 0;
	setAttr ".phl[958]" 0;
	setAttr ".phl[959]" 0;
	setAttr ".phl[960]" 0;
	setAttr ".phl[961]" 0;
	setAttr ".phl[962]" 0;
	setAttr ".phl[963]" 0;
	setAttr ".phl[964]" 0;
	setAttr ".phl[965]" 0;
	setAttr ".phl[966]" 0;
	setAttr ".phl[967]" 0;
	setAttr ".phl[968]" 0;
	setAttr ".ed" -type "dataReferenceEdits" 
		"ManRN"
		"ManRN" 0
		"ManRN" 1231
		2 "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main" "visibility" " 1"
		
		2 "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main" "translate" " -type \"double3\" 0 0 0"
		
		2 "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main" "translateX" " -av"
		
		2 "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main" "scale" " -type \"double3\" 1 1 1"
		
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:HipSwingerOffset_M|Man:HipSwinger_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"translateX" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"translateY" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"translateZ" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M" 
		"Global" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"follow" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"stretchy" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"antiPop" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"Lenght1" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"Lenght2" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"Fatness1" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"Fatness2" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R" 
		"volume" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"swivel" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"roll" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"rollStartAngle" " -k 1 30"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"rollEndAngle" " -k 1 60"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"stretchy" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"antiPop" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"Lenght1" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"Lenght2" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"Fatness1" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"Fatness2" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R" 
		"volume" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"follow" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"stretchy" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"antiPop" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"Lenght1" " -k 1 1.00000000174336501"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"Lenght2" " -k 1 1.00000001009188844"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"Fatness1" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"Fatness2" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L" 
		"volume" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"translateX" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"translateY" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"translateZ" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rotate" " -type \"double3\" 0 0 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rotateX" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rotateY" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rotateZ" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"swivel" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"roll" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rollStartAngle" " -k 1 30"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"rollEndAngle" " -k 1 60"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"stretchy" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"antiPop" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"Lenght1" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"Lenght2" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"Fatness1" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"Fatness2" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L" 
		"volume" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R|Man:PoleArm_R" 
		"follow" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R|Man:PoleArm_R" 
		"lock" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKSpineHandle_M" 
		"translate" " -type \"double3\" -3.2032355212396667e-09 128.16129270121149375 -4.34630976516275602"
		
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKSpineHandle_M" 
		"rotate" " -type \"double3\" 89.99999913127444984 9.06536706031184814 89.99999998418725511"
		
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M|Man:IKcvSpine1_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M|Man:IKcvSpine2_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M" 
		"followEnd" " -k 1 5"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M" 
		"stiff" " -k 1 5"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M" 
		"FixedOrient" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"stiff" " -k 1 5"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"stretchy" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"follow" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M" 
		"volume" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R|Man:PoleLeg_R" 
		"follow" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R|Man:PoleLeg_R" 
		"lock" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L|Man:PoleArm_L" 
		"follow" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L|Man:PoleArm_L" 
		"lock" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L|Man:PoleLeg_L" 
		"follow" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L|Man:PoleLeg_L" 
		"lock" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_R|Man:FKIKArm_R" 
		"FKIKBlend" " -k 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_R|Man:FKIKArm_R" 
		"FKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_R|Man:FKIKArm_R" 
		"IKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_R|Man:FKIKLeg_R" 
		"FKIKBlend" " -k 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_R|Man:FKIKLeg_R" 
		"FKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_R|Man:FKIKLeg_R" 
		"IKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintSpine_M|Man:FKIKSpine_M" 
		"FKIKBlend" " -k 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintSpine_M|Man:FKIKSpine_M" 
		"FKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintSpine_M|Man:FKIKSpine_M" 
		"IKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_L|Man:FKIKArm_L" 
		"FKIKBlend" " -k 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_L|Man:FKIKArm_L" 
		"FKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_L|Man:FKIKArm_L" 
		"IKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_L|Man:FKIKLeg_L" 
		"FKIKBlend" " -k 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_L|Man:FKIKLeg_L" 
		"FKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_L|Man:FKIKLeg_L" 
		"IKVis" " -k 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M" 
		"scale" " -type \"double3\" 1 1 1"
		2 "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M" 
		"follow" " -k 1 10"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"visibility" " 1"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"translate" " -type \"double3\" 0 0 0"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"translateX" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"translateY" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"translateZ" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"rotate" " -type \"double3\" 0 0 0"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"rotateX" " -av"
		2 "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M" 
		"CenterBtwFeet" " -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "spread" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "indexCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "middleCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "ringCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "pinkyCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_R" "thumbCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "spread" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "indexCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "middleCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "ringCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "pinkyCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:MotionSystem|Man:DrivingSystem|Man:Fingers_L" "thumbCurl" 
		" -k 1 0"
		2 "|Man:Group|Man:DeformationSystem|Man:Root_M" "translate" " -type \"double3\" 0 98.28510199018447224 -1.771720813802931"
		
		2 "|Man:Group|Man:DeformationSystem|Man:Root_M" "translateX" " -av"
		2 "|Man:Group|Man:DeformationSystem|Man:Root_M" "translateY" " -av"
		2 "|Man:Group|Man:DeformationSystem|Man:Root_M" "translateZ" " -av"
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.translateX" 
		"ManRN.placeHolderList[1]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.translateY" 
		"ManRN.placeHolderList[2]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.translateZ" 
		"ManRN.placeHolderList[3]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.rotateX" 
		"ManRN.placeHolderList[4]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.rotateY" 
		"ManRN.placeHolderList[5]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:MainSystem|Man:Main.rotateZ" 
		"ManRN.placeHolderList[6]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.translateX" 
		"ManRN.placeHolderList[7]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.translateY" 
		"ManRN.placeHolderList[8]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.translateZ" 
		"ManRN.placeHolderList[9]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.rotateX" 
		"ManRN.placeHolderList[10]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.rotateY" 
		"ManRN.placeHolderList[11]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M.rotateZ" 
		"ManRN.placeHolderList[12]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.translateX" 
		"ManRN.placeHolderList[13]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.translateY" 
		"ManRN.placeHolderList[14]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.translateZ" 
		"ManRN.placeHolderList[15]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.rotateX" 
		"ManRN.placeHolderList[16]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.rotateY" 
		"ManRN.placeHolderList[17]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M.rotateZ" 
		"ManRN.placeHolderList[18]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.translateX" 
		"ManRN.placeHolderList[19]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.translateY" 
		"ManRN.placeHolderList[20]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.translateZ" 
		"ManRN.placeHolderList[21]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.rotateX" 
		"ManRN.placeHolderList[22]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.rotateY" 
		"ManRN.placeHolderList[23]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M.rotateZ" 
		"ManRN.placeHolderList[24]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.translateX" 
		"ManRN.placeHolderList[25]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.translateY" 
		"ManRN.placeHolderList[26]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.translateZ" 
		"ManRN.placeHolderList[27]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.rotateX" 
		"ManRN.placeHolderList[28]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.rotateY" 
		"ManRN.placeHolderList[29]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M.rotateZ" 
		"ManRN.placeHolderList[30]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.translateX" 
		"ManRN.placeHolderList[31]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.translateY" 
		"ManRN.placeHolderList[32]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.translateZ" 
		"ManRN.placeHolderList[33]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.rotateX" 
		"ManRN.placeHolderList[34]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.rotateY" 
		"ManRN.placeHolderList[35]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M.rotateZ" 
		"ManRN.placeHolderList[36]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.translateX" 
		"ManRN.placeHolderList[37]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.translateY" 
		"ManRN.placeHolderList[38]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.translateZ" 
		"ManRN.placeHolderList[39]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.rotateX" 
		"ManRN.placeHolderList[40]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.rotateY" 
		"ManRN.placeHolderList[41]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M.rotateZ" 
		"ManRN.placeHolderList[42]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.translateX" 
		"ManRN.placeHolderList[43]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.translateY" 
		"ManRN.placeHolderList[44]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.translateZ" 
		"ManRN.placeHolderList[45]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.rotateX" 
		"ManRN.placeHolderList[46]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.rotateY" 
		"ManRN.placeHolderList[47]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M.rotateZ" 
		"ManRN.placeHolderList[48]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.translateX" 
		"ManRN.placeHolderList[49]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.translateY" 
		"ManRN.placeHolderList[50]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.translateZ" 
		"ManRN.placeHolderList[51]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.rotateX" 
		"ManRN.placeHolderList[52]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.rotateY" 
		"ManRN.placeHolderList[53]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:FKXRoot_M|Man:FKOffsetSpine1_M|Man:HipSwingerStabilizer|Man:FKExtraSpine1_M|Man:FKSpine1_M|Man:FKXSpine1_M|Man:FKOffsetSpine2_M|Man:FKExtraSpine2_M|Man:FKSpine2_M|Man:FKXSpine2_M|Man:FKOffsetChest_M|Man:FKExtraChest_M|Man:FKChest_M.rotateZ" 
		"ManRN.placeHolderList[54]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:HipSwingerOffset_M|Man:HipSwinger_M.rotateX" 
		"ManRN.placeHolderList[55]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:HipSwingerOffset_M|Man:HipSwinger_M.rotateY" 
		"ManRN.placeHolderList[56]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKFollowRoot|Man:FKOffsetRoot_M|Man:FKExtraRoot_M|Man:FKRoot_M|Man:HipSwingerOffset_M|Man:HipSwinger_M.rotateZ" 
		"ManRN.placeHolderList[57]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.translateX" 
		"ManRN.placeHolderList[58]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.translateY" 
		"ManRN.placeHolderList[59]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.translateZ" 
		"ManRN.placeHolderList[60]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.rotateX" 
		"ManRN.placeHolderList[61]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.rotateY" 
		"ManRN.placeHolderList[62]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M.rotateZ" 
		"ManRN.placeHolderList[63]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.translateX" 
		"ManRN.placeHolderList[64]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.translateY" 
		"ManRN.placeHolderList[65]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.translateZ" 
		"ManRN.placeHolderList[66]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.rotateX" 
		"ManRN.placeHolderList[67]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.rotateY" 
		"ManRN.placeHolderList[68]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M.rotateZ" 
		"ManRN.placeHolderList[69]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.translateX" 
		"ManRN.placeHolderList[70]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.translateY" 
		"ManRN.placeHolderList[71]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.translateZ" 
		"ManRN.placeHolderList[72]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.rotateX" 
		"ManRN.placeHolderList[73]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.rotateY" 
		"ManRN.placeHolderList[74]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M.rotateZ" 
		"ManRN.placeHolderList[75]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.translateX" 
		"ManRN.placeHolderList[76]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.translateY" 
		"ManRN.placeHolderList[77]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.translateZ" 
		"ManRN.placeHolderList[78]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.rotateX" 
		"ManRN.placeHolderList[79]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.rotateY" 
		"ManRN.placeHolderList[80]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M.rotateZ" 
		"ManRN.placeHolderList[81]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.translateX" 
		"ManRN.placeHolderList[82]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.translateY" 
		"ManRN.placeHolderList[83]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.translateZ" 
		"ManRN.placeHolderList[84]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.rotateX" 
		"ManRN.placeHolderList[85]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.rotateY" 
		"ManRN.placeHolderList[86]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M.rotateZ" 
		"ManRN.placeHolderList[87]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.translateX" 
		"ManRN.placeHolderList[88]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.translateY" 
		"ManRN.placeHolderList[89]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.translateZ" 
		"ManRN.placeHolderList[90]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.rotateX" 
		"ManRN.placeHolderList[91]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.rotateY" 
		"ManRN.placeHolderList[92]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKOffsetJaw_M|Man:FKExtraJaw_M|Man:FKJaw_M.rotateZ" 
		"ManRN.placeHolderList[93]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.translateX" 
		"ManRN.placeHolderList[94]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.translateY" 
		"ManRN.placeHolderList[95]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.translateZ" 
		"ManRN.placeHolderList[96]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.rotateX" 
		"ManRN.placeHolderList[97]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.rotateY" 
		"ManRN.placeHolderList[98]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R.rotateZ" 
		"ManRN.placeHolderList[99]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.translateX" 
		"ManRN.placeHolderList[100]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.translateY" 
		"ManRN.placeHolderList[101]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.translateZ" 
		"ManRN.placeHolderList[102]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.rotateX" 
		"ManRN.placeHolderList[103]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.rotateY" 
		"ManRN.placeHolderList[104]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_R|Man:FKOffsetEye_R|Man:FKExtraEye_R|Man:FKEye_R.rotateZ" 
		"ManRN.placeHolderList[105]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.translateX" 
		"ManRN.placeHolderList[106]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.translateY" 
		"ManRN.placeHolderList[107]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.translateZ" 
		"ManRN.placeHolderList[108]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.rotateX" 
		"ManRN.placeHolderList[109]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.rotateY" 
		"ManRN.placeHolderList[110]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L.rotateZ" 
		"ManRN.placeHolderList[111]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.translateX" 
		"ManRN.placeHolderList[112]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.translateY" 
		"ManRN.placeHolderList[113]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.translateZ" 
		"ManRN.placeHolderList[114]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.rotateX" 
		"ManRN.placeHolderList[115]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.rotateY" 
		"ManRN.placeHolderList[116]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetNeck_M|Man:FKExtraNeck_M|Man:FKNeck_M|Man:FKXNeck_M|Man:FKOffsetHead_M|Man:FKGlobalStaticHead_M|Man:FKGlobalHead_M|Man:FKExtraHead_M|Man:FKHead_M|Man:FKXHead_M|Man:FKAimEye_L|Man:FKOffsetEye_L|Man:FKExtraEye_L|Man:FKEye_L.rotateZ" 
		"ManRN.placeHolderList[117]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.translateX" 
		"ManRN.placeHolderList[118]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.translateY" 
		"ManRN.placeHolderList[119]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.translateZ" 
		"ManRN.placeHolderList[120]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.rotateX" 
		"ManRN.placeHolderList[121]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.rotateY" 
		"ManRN.placeHolderList[122]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R.rotateZ" 
		"ManRN.placeHolderList[123]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.translateX" 
		"ManRN.placeHolderList[124]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.translateY" 
		"ManRN.placeHolderList[125]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.translateZ" 
		"ManRN.placeHolderList[126]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.rotateX" 
		"ManRN.placeHolderList[127]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.rotateY" 
		"ManRN.placeHolderList[128]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_R|Man:FKExtraScapula_R|Man:FKScapula_R.rotateZ" 
		"ManRN.placeHolderList[129]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.translateX" 
		"ManRN.placeHolderList[130]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.translateY" 
		"ManRN.placeHolderList[131]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.translateZ" 
		"ManRN.placeHolderList[132]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.rotateX" 
		"ManRN.placeHolderList[133]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.rotateY" 
		"ManRN.placeHolderList[134]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L.rotateZ" 
		"ManRN.placeHolderList[135]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.translateX" 
		"ManRN.placeHolderList[136]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.translateY" 
		"ManRN.placeHolderList[137]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.translateZ" 
		"ManRN.placeHolderList[138]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.rotateX" 
		"ManRN.placeHolderList[139]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.rotateY" 
		"ManRN.placeHolderList[140]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToChest_M|Man:FKOffsetScapula_L|Man:FKExtraScapula_L|Man:FKScapula_L.rotateZ" 
		"ManRN.placeHolderList[141]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.translateX" 
		"ManRN.placeHolderList[142]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.translateY" 
		"ManRN.placeHolderList[143]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.translateZ" 
		"ManRN.placeHolderList[144]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.rotateX" 
		"ManRN.placeHolderList[145]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.rotateY" 
		"ManRN.placeHolderList[146]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R.rotateZ" 
		"ManRN.placeHolderList[147]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.translateX" 
		"ManRN.placeHolderList[148]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.translateY" 
		"ManRN.placeHolderList[149]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.translateZ" 
		"ManRN.placeHolderList[150]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.rotateX" 
		"ManRN.placeHolderList[151]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.rotateY" 
		"ManRN.placeHolderList[152]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R.rotateZ" 
		"ManRN.placeHolderList[153]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.translateX" 
		"ManRN.placeHolderList[154]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.translateY" 
		"ManRN.placeHolderList[155]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.translateZ" 
		"ManRN.placeHolderList[156]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.rotateX" 
		"ManRN.placeHolderList[157]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.rotateY" 
		"ManRN.placeHolderList[158]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R.rotateZ" 
		"ManRN.placeHolderList[159]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.translateX" 
		"ManRN.placeHolderList[160]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.translateY" 
		"ManRN.placeHolderList[161]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.translateZ" 
		"ManRN.placeHolderList[162]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.rotateX" 
		"ManRN.placeHolderList[163]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.rotateY" 
		"ManRN.placeHolderList[164]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R.rotateZ" 
		"ManRN.placeHolderList[165]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.translateX" 
		"ManRN.placeHolderList[166]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.translateY" 
		"ManRN.placeHolderList[167]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.translateZ" 
		"ManRN.placeHolderList[168]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.rotateX" 
		"ManRN.placeHolderList[169]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.rotateY" 
		"ManRN.placeHolderList[170]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R.rotateZ" 
		"ManRN.placeHolderList[171]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.translateX" 
		"ManRN.placeHolderList[172]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.translateY" 
		"ManRN.placeHolderList[173]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.translateZ" 
		"ManRN.placeHolderList[174]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.rotateX" 
		"ManRN.placeHolderList[175]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.rotateY" 
		"ManRN.placeHolderList[176]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetMiddleFinger1_R|Man:SDKFKMiddleFinger1_R|Man:FKExtraMiddleFinger1_R|Man:FKMiddleFinger1_R|Man:FKXMiddleFinger1_R|Man:FKOffsetMiddleFinger2_R|Man:SDKFKMiddleFinger2_R|Man:FKExtraMiddleFinger2_R|Man:FKMiddleFinger2_R|Man:FKXMiddleFinger2_R|Man:FKOffsetMiddleFinger3_R|Man:SDKFKMiddleFinger3_R|Man:FKExtraMiddleFinger3_R|Man:FKMiddleFinger3_R.rotateZ" 
		"ManRN.placeHolderList[177]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.translateX" 
		"ManRN.placeHolderList[178]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.translateY" 
		"ManRN.placeHolderList[179]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.translateZ" 
		"ManRN.placeHolderList[180]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.rotateX" 
		"ManRN.placeHolderList[181]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.rotateY" 
		"ManRN.placeHolderList[182]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R.rotateZ" 
		"ManRN.placeHolderList[183]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.translateX" 
		"ManRN.placeHolderList[184]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.translateY" 
		"ManRN.placeHolderList[185]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.translateZ" 
		"ManRN.placeHolderList[186]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.rotateX" 
		"ManRN.placeHolderList[187]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.rotateY" 
		"ManRN.placeHolderList[188]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R.rotateZ" 
		"ManRN.placeHolderList[189]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.translateX" 
		"ManRN.placeHolderList[190]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.translateY" 
		"ManRN.placeHolderList[191]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.translateZ" 
		"ManRN.placeHolderList[192]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.rotateX" 
		"ManRN.placeHolderList[193]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.rotateY" 
		"ManRN.placeHolderList[194]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R.rotateZ" 
		"ManRN.placeHolderList[195]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.translateX" 
		"ManRN.placeHolderList[196]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.translateY" 
		"ManRN.placeHolderList[197]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.translateZ" 
		"ManRN.placeHolderList[198]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.rotateX" 
		"ManRN.placeHolderList[199]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.rotateY" 
		"ManRN.placeHolderList[200]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R.rotateZ" 
		"ManRN.placeHolderList[201]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.translateX" 
		"ManRN.placeHolderList[202]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.translateY" 
		"ManRN.placeHolderList[203]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.translateZ" 
		"ManRN.placeHolderList[204]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.rotateX" 
		"ManRN.placeHolderList[205]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.rotateY" 
		"ManRN.placeHolderList[206]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R.rotateZ" 
		"ManRN.placeHolderList[207]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.translateX" 
		"ManRN.placeHolderList[208]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.translateY" 
		"ManRN.placeHolderList[209]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.translateZ" 
		"ManRN.placeHolderList[210]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.rotateX" 
		"ManRN.placeHolderList[211]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.rotateY" 
		"ManRN.placeHolderList[212]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetThumbFinger1_R|Man:FKExtraThumbFinger1_R|Man:FKThumbFinger1_R|Man:FKXThumbFinger1_R|Man:FKOffsetThumbFinger2_R|Man:SDKFKThumbFinger2_R|Man:FKExtraThumbFinger2_R|Man:FKThumbFinger2_R|Man:FKXThumbFinger2_R|Man:FKOffsetThumbFinger3_R|Man:SDKFKThumbFinger3_R|Man:FKExtraThumbFinger3_R|Man:FKThumbFinger3_R.rotateZ" 
		"ManRN.placeHolderList[213]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.translateX" 
		"ManRN.placeHolderList[214]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.translateY" 
		"ManRN.placeHolderList[215]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.translateZ" 
		"ManRN.placeHolderList[216]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.rotateX" 
		"ManRN.placeHolderList[217]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.rotateY" 
		"ManRN.placeHolderList[218]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R.rotateZ" 
		"ManRN.placeHolderList[219]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.translateX" 
		"ManRN.placeHolderList[220]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.translateY" 
		"ManRN.placeHolderList[221]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.translateZ" 
		"ManRN.placeHolderList[222]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.rotateX" 
		"ManRN.placeHolderList[223]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.rotateY" 
		"ManRN.placeHolderList[224]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R.rotateZ" 
		"ManRN.placeHolderList[225]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.translateX" 
		"ManRN.placeHolderList[226]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.translateY" 
		"ManRN.placeHolderList[227]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.translateZ" 
		"ManRN.placeHolderList[228]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.rotateX" 
		"ManRN.placeHolderList[229]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.rotateY" 
		"ManRN.placeHolderList[230]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R.rotateZ" 
		"ManRN.placeHolderList[231]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.translateX" 
		"ManRN.placeHolderList[232]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.translateY" 
		"ManRN.placeHolderList[233]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.translateZ" 
		"ManRN.placeHolderList[234]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.rotateX" 
		"ManRN.placeHolderList[235]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.rotateY" 
		"ManRN.placeHolderList[236]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R.rotateZ" 
		"ManRN.placeHolderList[237]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.translateX" 
		"ManRN.placeHolderList[238]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.translateY" 
		"ManRN.placeHolderList[239]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.translateZ" 
		"ManRN.placeHolderList[240]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.rotateX" 
		"ManRN.placeHolderList[241]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.rotateY" 
		"ManRN.placeHolderList[242]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R.rotateZ" 
		"ManRN.placeHolderList[243]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.translateX" 
		"ManRN.placeHolderList[244]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.translateY" 
		"ManRN.placeHolderList[245]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.translateZ" 
		"ManRN.placeHolderList[246]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.rotateX" 
		"ManRN.placeHolderList[247]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.rotateY" 
		"ManRN.placeHolderList[248]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetIndexFinger1_R|Man:SDKFKIndexFinger1_R|Man:FKExtraIndexFinger1_R|Man:FKIndexFinger1_R|Man:FKXIndexFinger1_R|Man:FKOffsetIndexFinger2_R|Man:SDKFKIndexFinger2_R|Man:FKExtraIndexFinger2_R|Man:FKIndexFinger2_R|Man:FKXIndexFinger2_R|Man:FKOffsetIndexFinger3_R|Man:SDKFKIndexFinger3_R|Man:FKExtraIndexFinger3_R|Man:FKIndexFinger3_R.rotateZ" 
		"ManRN.placeHolderList[249]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.translateX" 
		"ManRN.placeHolderList[250]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.translateY" 
		"ManRN.placeHolderList[251]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.translateZ" 
		"ManRN.placeHolderList[252]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.rotateX" 
		"ManRN.placeHolderList[253]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.rotateY" 
		"ManRN.placeHolderList[254]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R.rotateZ" 
		"ManRN.placeHolderList[255]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.translateX" 
		"ManRN.placeHolderList[256]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.translateY" 
		"ManRN.placeHolderList[257]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.translateZ" 
		"ManRN.placeHolderList[258]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.rotateX" 
		"ManRN.placeHolderList[259]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.rotateY" 
		"ManRN.placeHolderList[260]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R.rotateZ" 
		"ManRN.placeHolderList[261]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.translateX" 
		"ManRN.placeHolderList[262]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.translateY" 
		"ManRN.placeHolderList[263]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.translateZ" 
		"ManRN.placeHolderList[264]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.rotateX" 
		"ManRN.placeHolderList[265]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.rotateY" 
		"ManRN.placeHolderList[266]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R.rotateZ" 
		"ManRN.placeHolderList[267]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.translateX" 
		"ManRN.placeHolderList[268]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.translateY" 
		"ManRN.placeHolderList[269]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.translateZ" 
		"ManRN.placeHolderList[270]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.rotateX" 
		"ManRN.placeHolderList[271]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.rotateY" 
		"ManRN.placeHolderList[272]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R.rotateZ" 
		"ManRN.placeHolderList[273]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.translateX" 
		"ManRN.placeHolderList[274]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.translateY" 
		"ManRN.placeHolderList[275]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.translateZ" 
		"ManRN.placeHolderList[276]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.rotateX" 
		"ManRN.placeHolderList[277]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.rotateY" 
		"ManRN.placeHolderList[278]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R.rotateZ" 
		"ManRN.placeHolderList[279]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.translateX" 
		"ManRN.placeHolderList[280]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.translateY" 
		"ManRN.placeHolderList[281]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.translateZ" 
		"ManRN.placeHolderList[282]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.rotateX" 
		"ManRN.placeHolderList[283]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.rotateY" 
		"ManRN.placeHolderList[284]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetRingFinger1_R|Man:SDKFKRingFinger1_R|Man:FKExtraRingFinger1_R|Man:FKRingFinger1_R|Man:FKXRingFinger1_R|Man:FKOffsetRingFinger2_R|Man:SDKFKRingFinger2_R|Man:FKExtraRingFinger2_R|Man:FKRingFinger2_R|Man:FKXRingFinger2_R|Man:FKOffsetRingFinger3_R|Man:SDKFKRingFinger3_R|Man:FKExtraRingFinger3_R|Man:FKRingFinger3_R.rotateZ" 
		"ManRN.placeHolderList[285]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.translateX" 
		"ManRN.placeHolderList[286]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.translateY" 
		"ManRN.placeHolderList[287]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.translateZ" 
		"ManRN.placeHolderList[288]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.rotateX" 
		"ManRN.placeHolderList[289]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.rotateY" 
		"ManRN.placeHolderList[290]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R.rotateZ" 
		"ManRN.placeHolderList[291]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.translateX" 
		"ManRN.placeHolderList[292]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.translateY" 
		"ManRN.placeHolderList[293]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.translateZ" 
		"ManRN.placeHolderList[294]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.rotateX" 
		"ManRN.placeHolderList[295]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.rotateY" 
		"ManRN.placeHolderList[296]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R.rotateZ" 
		"ManRN.placeHolderList[297]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.translateX" 
		"ManRN.placeHolderList[298]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.translateY" 
		"ManRN.placeHolderList[299]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.translateZ" 
		"ManRN.placeHolderList[300]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.rotateX" 
		"ManRN.placeHolderList[301]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.rotateY" 
		"ManRN.placeHolderList[302]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R.rotateZ" 
		"ManRN.placeHolderList[303]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.translateX" 
		"ManRN.placeHolderList[304]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.translateY" 
		"ManRN.placeHolderList[305]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.translateZ" 
		"ManRN.placeHolderList[306]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.rotateX" 
		"ManRN.placeHolderList[307]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.rotateY" 
		"ManRN.placeHolderList[308]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R.rotateZ" 
		"ManRN.placeHolderList[309]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.translateX" 
		"ManRN.placeHolderList[310]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.translateY" 
		"ManRN.placeHolderList[311]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.translateZ" 
		"ManRN.placeHolderList[312]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.rotateX" 
		"ManRN.placeHolderList[313]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.rotateY" 
		"ManRN.placeHolderList[314]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R.rotateZ" 
		"ManRN.placeHolderList[315]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.translateX" 
		"ManRN.placeHolderList[316]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.translateY" 
		"ManRN.placeHolderList[317]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.translateZ" 
		"ManRN.placeHolderList[318]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.rotateX" 
		"ManRN.placeHolderList[319]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.rotateY" 
		"ManRN.placeHolderList[320]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_R|Man:FKOffsetPinkyFinger1_R|Man:SDKFKPinkyFinger1_R|Man:FKExtraPinkyFinger1_R|Man:FKPinkyFinger1_R|Man:FKXPinkyFinger1_R|Man:FKOffsetPinkyFinger2_R|Man:SDKFKPinkyFinger2_R|Man:FKExtraPinkyFinger2_R|Man:FKPinkyFinger2_R|Man:FKXPinkyFinger2_R|Man:FKOffsetPinkyFinger3_R|Man:SDKFKPinkyFinger3_R|Man:FKExtraPinkyFinger3_R|Man:FKPinkyFinger3_R.rotateZ" 
		"ManRN.placeHolderList[321]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.translateX" 
		"ManRN.placeHolderList[322]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.translateY" 
		"ManRN.placeHolderList[323]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.translateZ" 
		"ManRN.placeHolderList[324]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.rotateX" 
		"ManRN.placeHolderList[325]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.rotateY" 
		"ManRN.placeHolderList[326]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R.rotateZ" 
		"ManRN.placeHolderList[327]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.translateX" 
		"ManRN.placeHolderList[328]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.translateY" 
		"ManRN.placeHolderList[329]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.translateZ" 
		"ManRN.placeHolderList[330]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.rotateX" 
		"ManRN.placeHolderList[331]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.rotateY" 
		"ManRN.placeHolderList[332]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R.rotateZ" 
		"ManRN.placeHolderList[333]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.translateX" 
		"ManRN.placeHolderList[334]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.translateY" 
		"ManRN.placeHolderList[335]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.translateZ" 
		"ManRN.placeHolderList[336]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.rotateX" 
		"ManRN.placeHolderList[337]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.rotateY" 
		"ManRN.placeHolderList[338]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R.rotateZ" 
		"ManRN.placeHolderList[339]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.translateX" 
		"ManRN.placeHolderList[340]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.translateY" 
		"ManRN.placeHolderList[341]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.translateZ" 
		"ManRN.placeHolderList[342]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.rotateX" 
		"ManRN.placeHolderList[343]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.rotateY" 
		"ManRN.placeHolderList[344]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R.rotateZ" 
		"ManRN.placeHolderList[345]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.translateX" 
		"ManRN.placeHolderList[346]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.translateY" 
		"ManRN.placeHolderList[347]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.translateZ" 
		"ManRN.placeHolderList[348]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.rotateX" 
		"ManRN.placeHolderList[349]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.rotateY" 
		"ManRN.placeHolderList[350]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R.rotateZ" 
		"ManRN.placeHolderList[351]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.translateX" 
		"ManRN.placeHolderList[352]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.translateY" 
		"ManRN.placeHolderList[353]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.translateZ" 
		"ManRN.placeHolderList[354]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.rotateX" 
		"ManRN.placeHolderList[355]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.rotateY" 
		"ManRN.placeHolderList[356]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_R|Man:FKOffsetShoulder_R|Man:FKExtraShoulder_R|Man:FKShoulder_R|Man:FKXShoulder_R|Man:FKOffsetElbow_R|Man:FKExtraElbow_R|Man:FKElbow_R|Man:FKXElbow_R|Man:FKOffsetWrist_R|Man:FKExtraWrist_R|Man:FKWrist_R.rotateZ" 
		"ManRN.placeHolderList[357]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.translateX" 
		"ManRN.placeHolderList[358]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.translateY" 
		"ManRN.placeHolderList[359]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.translateZ" 
		"ManRN.placeHolderList[360]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.rotateX" 
		"ManRN.placeHolderList[361]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.rotateY" 
		"ManRN.placeHolderList[362]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R.rotateZ" 
		"ManRN.placeHolderList[363]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.translateX" 
		"ManRN.placeHolderList[364]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.translateY" 
		"ManRN.placeHolderList[365]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.translateZ" 
		"ManRN.placeHolderList[366]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.rotateX" 
		"ManRN.placeHolderList[367]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.rotateY" 
		"ManRN.placeHolderList[368]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R.rotateZ" 
		"ManRN.placeHolderList[369]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.translateX" 
		"ManRN.placeHolderList[370]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.translateY" 
		"ManRN.placeHolderList[371]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.translateZ" 
		"ManRN.placeHolderList[372]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.rotateX" 
		"ManRN.placeHolderList[373]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.rotateY" 
		"ManRN.placeHolderList[374]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R.rotateZ" 
		"ManRN.placeHolderList[375]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.translateX" 
		"ManRN.placeHolderList[376]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.translateY" 
		"ManRN.placeHolderList[377]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.translateZ" 
		"ManRN.placeHolderList[378]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.rotateX" 
		"ManRN.placeHolderList[379]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.rotateY" 
		"ManRN.placeHolderList[380]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R.rotateZ" 
		"ManRN.placeHolderList[381]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.translateX" 
		"ManRN.placeHolderList[382]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.translateY" 
		"ManRN.placeHolderList[383]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.translateZ" 
		"ManRN.placeHolderList[384]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.rotateX" 
		"ManRN.placeHolderList[385]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.rotateY" 
		"ManRN.placeHolderList[386]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R.rotateZ" 
		"ManRN.placeHolderList[387]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.translateX" 
		"ManRN.placeHolderList[388]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.translateY" 
		"ManRN.placeHolderList[389]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.translateZ" 
		"ManRN.placeHolderList[390]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.rotateX" 
		"ManRN.placeHolderList[391]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.rotateY" 
		"ManRN.placeHolderList[392]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R.rotateZ" 
		"ManRN.placeHolderList[393]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.translateX" 
		"ManRN.placeHolderList[394]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.translateY" 
		"ManRN.placeHolderList[395]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.translateZ" 
		"ManRN.placeHolderList[396]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.rotateX" 
		"ManRN.placeHolderList[397]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.rotateY" 
		"ManRN.placeHolderList[398]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R.rotateZ" 
		"ManRN.placeHolderList[399]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.translateX" 
		"ManRN.placeHolderList[400]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.translateY" 
		"ManRN.placeHolderList[401]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.translateZ" 
		"ManRN.placeHolderList[402]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.rotateX" 
		"ManRN.placeHolderList[403]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.rotateY" 
		"ManRN.placeHolderList[404]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_R|Man:FKExtraHip_R|Man:FKHip_R|Man:FKXHip_R|Man:FKOffsetKnee_R|Man:FKExtraKnee_R|Man:FKKnee_R|Man:FKXKnee_R|Man:FKOffsetAnkle_R|Man:FKExtraAnkle_R|Man:FKAnkle_R|Man:FKXAnkle_R|Man:FKOffsetToes_R|Man:FKExtraToes_R|Man:FKToes_R.rotateZ" 
		"ManRN.placeHolderList[405]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.translateX" 
		"ManRN.placeHolderList[406]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.translateY" 
		"ManRN.placeHolderList[407]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.translateZ" 
		"ManRN.placeHolderList[408]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.rotateX" 
		"ManRN.placeHolderList[409]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.rotateY" 
		"ManRN.placeHolderList[410]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L.rotateZ" 
		"ManRN.placeHolderList[411]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.translateX" 
		"ManRN.placeHolderList[412]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.translateY" 
		"ManRN.placeHolderList[413]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.translateZ" 
		"ManRN.placeHolderList[414]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.rotateX" 
		"ManRN.placeHolderList[415]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.rotateY" 
		"ManRN.placeHolderList[416]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L.rotateZ" 
		"ManRN.placeHolderList[417]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.translateX" 
		"ManRN.placeHolderList[418]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.translateY" 
		"ManRN.placeHolderList[419]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.translateZ" 
		"ManRN.placeHolderList[420]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.rotateX" 
		"ManRN.placeHolderList[421]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.rotateY" 
		"ManRN.placeHolderList[422]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L.rotateZ" 
		"ManRN.placeHolderList[423]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.translateX" 
		"ManRN.placeHolderList[424]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.translateY" 
		"ManRN.placeHolderList[425]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.translateZ" 
		"ManRN.placeHolderList[426]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.rotateX" 
		"ManRN.placeHolderList[427]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.rotateY" 
		"ManRN.placeHolderList[428]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L.rotateZ" 
		"ManRN.placeHolderList[429]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.translateX" 
		"ManRN.placeHolderList[430]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.translateY" 
		"ManRN.placeHolderList[431]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.translateZ" 
		"ManRN.placeHolderList[432]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.rotateX" 
		"ManRN.placeHolderList[433]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.rotateY" 
		"ManRN.placeHolderList[434]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L.rotateZ" 
		"ManRN.placeHolderList[435]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.translateX" 
		"ManRN.placeHolderList[436]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.translateY" 
		"ManRN.placeHolderList[437]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.translateZ" 
		"ManRN.placeHolderList[438]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.rotateX" 
		"ManRN.placeHolderList[439]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.rotateY" 
		"ManRN.placeHolderList[440]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L.rotateZ" 
		"ManRN.placeHolderList[441]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.translateX" 
		"ManRN.placeHolderList[442]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.translateY" 
		"ManRN.placeHolderList[443]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.translateZ" 
		"ManRN.placeHolderList[444]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.rotateX" 
		"ManRN.placeHolderList[445]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.rotateY" 
		"ManRN.placeHolderList[446]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L.rotateZ" 
		"ManRN.placeHolderList[447]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.translateX" 
		"ManRN.placeHolderList[448]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.translateY" 
		"ManRN.placeHolderList[449]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.translateZ" 
		"ManRN.placeHolderList[450]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.rotateX" 
		"ManRN.placeHolderList[451]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.rotateY" 
		"ManRN.placeHolderList[452]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToRoot_M|Man:FKOffsetHip_L|Man:FKExtraHip_L|Man:FKHip_L|Man:FKXHip_L|Man:FKOffsetKnee_L|Man:FKExtraKnee_L|Man:FKKnee_L|Man:FKXKnee_L|Man:FKOffsetAnkle_L|Man:FKExtraAnkle_L|Man:FKAnkle_L|Man:FKXAnkle_L|Man:FKOffsetToes_L|Man:FKExtraToes_L|Man:FKToes_L.rotateZ" 
		"ManRN.placeHolderList[453]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.translateX" 
		"ManRN.placeHolderList[454]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.translateY" 
		"ManRN.placeHolderList[455]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.translateZ" 
		"ManRN.placeHolderList[456]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.rotateX" 
		"ManRN.placeHolderList[457]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.rotateY" 
		"ManRN.placeHolderList[458]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L.rotateZ" 
		"ManRN.placeHolderList[459]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.translateX" 
		"ManRN.placeHolderList[460]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.translateY" 
		"ManRN.placeHolderList[461]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.translateZ" 
		"ManRN.placeHolderList[462]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.rotateX" 
		"ManRN.placeHolderList[463]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.rotateY" 
		"ManRN.placeHolderList[464]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L.rotateZ" 
		"ManRN.placeHolderList[465]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.translateX" 
		"ManRN.placeHolderList[466]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.translateY" 
		"ManRN.placeHolderList[467]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.translateZ" 
		"ManRN.placeHolderList[468]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.rotateX" 
		"ManRN.placeHolderList[469]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.rotateY" 
		"ManRN.placeHolderList[470]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L.rotateZ" 
		"ManRN.placeHolderList[471]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.translateX" 
		"ManRN.placeHolderList[472]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.translateY" 
		"ManRN.placeHolderList[473]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.translateZ" 
		"ManRN.placeHolderList[474]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.rotateX" 
		"ManRN.placeHolderList[475]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.rotateY" 
		"ManRN.placeHolderList[476]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L.rotateZ" 
		"ManRN.placeHolderList[477]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.translateX" 
		"ManRN.placeHolderList[478]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.translateY" 
		"ManRN.placeHolderList[479]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.translateZ" 
		"ManRN.placeHolderList[480]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.rotateX" 
		"ManRN.placeHolderList[481]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.rotateY" 
		"ManRN.placeHolderList[482]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L.rotateZ" 
		"ManRN.placeHolderList[483]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.translateX" 
		"ManRN.placeHolderList[484]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.translateY" 
		"ManRN.placeHolderList[485]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.translateZ" 
		"ManRN.placeHolderList[486]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.rotateX" 
		"ManRN.placeHolderList[487]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.rotateY" 
		"ManRN.placeHolderList[488]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetMiddleFinger1_L|Man:SDKFKMiddleFinger1_L|Man:FKExtraMiddleFinger1_L|Man:FKMiddleFinger1_L|Man:FKXMiddleFinger1_L|Man:FKOffsetMiddleFinger2_L|Man:SDKFKMiddleFinger2_L|Man:FKExtraMiddleFinger2_L|Man:FKMiddleFinger2_L|Man:FKXMiddleFinger2_L|Man:FKOffsetMiddleFinger3_L|Man:SDKFKMiddleFinger3_L|Man:FKExtraMiddleFinger3_L|Man:FKMiddleFinger3_L.rotateZ" 
		"ManRN.placeHolderList[489]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.translateX" 
		"ManRN.placeHolderList[490]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.translateY" 
		"ManRN.placeHolderList[491]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.translateZ" 
		"ManRN.placeHolderList[492]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.rotateX" 
		"ManRN.placeHolderList[493]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.rotateY" 
		"ManRN.placeHolderList[494]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L.rotateZ" 
		"ManRN.placeHolderList[495]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.translateX" 
		"ManRN.placeHolderList[496]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.translateY" 
		"ManRN.placeHolderList[497]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.translateZ" 
		"ManRN.placeHolderList[498]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.rotateX" 
		"ManRN.placeHolderList[499]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.rotateY" 
		"ManRN.placeHolderList[500]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L.rotateZ" 
		"ManRN.placeHolderList[501]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.translateX" 
		"ManRN.placeHolderList[502]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.translateY" 
		"ManRN.placeHolderList[503]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.translateZ" 
		"ManRN.placeHolderList[504]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.rotateX" 
		"ManRN.placeHolderList[505]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.rotateY" 
		"ManRN.placeHolderList[506]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L.rotateZ" 
		"ManRN.placeHolderList[507]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.translateX" 
		"ManRN.placeHolderList[508]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.translateY" 
		"ManRN.placeHolderList[509]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.translateZ" 
		"ManRN.placeHolderList[510]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.rotateX" 
		"ManRN.placeHolderList[511]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.rotateY" 
		"ManRN.placeHolderList[512]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L.rotateZ" 
		"ManRN.placeHolderList[513]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.translateX" 
		"ManRN.placeHolderList[514]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.translateY" 
		"ManRN.placeHolderList[515]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.translateZ" 
		"ManRN.placeHolderList[516]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.rotateX" 
		"ManRN.placeHolderList[517]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.rotateY" 
		"ManRN.placeHolderList[518]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L.rotateZ" 
		"ManRN.placeHolderList[519]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.translateX" 
		"ManRN.placeHolderList[520]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.translateY" 
		"ManRN.placeHolderList[521]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.translateZ" 
		"ManRN.placeHolderList[522]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.rotateX" 
		"ManRN.placeHolderList[523]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.rotateY" 
		"ManRN.placeHolderList[524]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetThumbFinger1_L|Man:FKExtraThumbFinger1_L|Man:FKThumbFinger1_L|Man:FKXThumbFinger1_L|Man:FKOffsetThumbFinger2_L|Man:SDKFKThumbFinger2_L|Man:FKExtraThumbFinger2_L|Man:FKThumbFinger2_L|Man:FKXThumbFinger2_L|Man:FKOffsetThumbFinger3_L|Man:SDKFKThumbFinger3_L|Man:FKExtraThumbFinger3_L|Man:FKThumbFinger3_L.rotateZ" 
		"ManRN.placeHolderList[525]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.translateX" 
		"ManRN.placeHolderList[526]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.translateY" 
		"ManRN.placeHolderList[527]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.translateZ" 
		"ManRN.placeHolderList[528]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.rotateX" 
		"ManRN.placeHolderList[529]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.rotateY" 
		"ManRN.placeHolderList[530]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L.rotateZ" 
		"ManRN.placeHolderList[531]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.translateX" 
		"ManRN.placeHolderList[532]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.translateY" 
		"ManRN.placeHolderList[533]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.translateZ" 
		"ManRN.placeHolderList[534]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.rotateX" 
		"ManRN.placeHolderList[535]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.rotateY" 
		"ManRN.placeHolderList[536]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L.rotateZ" 
		"ManRN.placeHolderList[537]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.translateX" 
		"ManRN.placeHolderList[538]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.translateY" 
		"ManRN.placeHolderList[539]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.translateZ" 
		"ManRN.placeHolderList[540]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.rotateX" 
		"ManRN.placeHolderList[541]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.rotateY" 
		"ManRN.placeHolderList[542]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L.rotateZ" 
		"ManRN.placeHolderList[543]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.translateX" 
		"ManRN.placeHolderList[544]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.translateY" 
		"ManRN.placeHolderList[545]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.translateZ" 
		"ManRN.placeHolderList[546]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.rotateX" 
		"ManRN.placeHolderList[547]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.rotateY" 
		"ManRN.placeHolderList[548]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L.rotateZ" 
		"ManRN.placeHolderList[549]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.translateX" 
		"ManRN.placeHolderList[550]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.translateY" 
		"ManRN.placeHolderList[551]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.translateZ" 
		"ManRN.placeHolderList[552]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.rotateX" 
		"ManRN.placeHolderList[553]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.rotateY" 
		"ManRN.placeHolderList[554]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L.rotateZ" 
		"ManRN.placeHolderList[555]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.translateX" 
		"ManRN.placeHolderList[556]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.translateY" 
		"ManRN.placeHolderList[557]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.translateZ" 
		"ManRN.placeHolderList[558]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.rotateX" 
		"ManRN.placeHolderList[559]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.rotateY" 
		"ManRN.placeHolderList[560]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetIndexFinger1_L|Man:SDKFKIndexFinger1_L|Man:FKExtraIndexFinger1_L|Man:FKIndexFinger1_L|Man:FKXIndexFinger1_L|Man:FKOffsetIndexFinger2_L|Man:SDKFKIndexFinger2_L|Man:FKExtraIndexFinger2_L|Man:FKIndexFinger2_L|Man:FKXIndexFinger2_L|Man:FKOffsetIndexFinger3_L|Man:SDKFKIndexFinger3_L|Man:FKExtraIndexFinger3_L|Man:FKIndexFinger3_L.rotateZ" 
		"ManRN.placeHolderList[561]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.translateX" 
		"ManRN.placeHolderList[562]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.translateY" 
		"ManRN.placeHolderList[563]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.translateZ" 
		"ManRN.placeHolderList[564]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.rotateX" 
		"ManRN.placeHolderList[565]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.rotateY" 
		"ManRN.placeHolderList[566]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L.rotateZ" 
		"ManRN.placeHolderList[567]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.translateX" 
		"ManRN.placeHolderList[568]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.translateY" 
		"ManRN.placeHolderList[569]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.translateZ" 
		"ManRN.placeHolderList[570]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.rotateX" 
		"ManRN.placeHolderList[571]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.rotateY" 
		"ManRN.placeHolderList[572]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L.rotateZ" 
		"ManRN.placeHolderList[573]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.translateX" 
		"ManRN.placeHolderList[574]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.translateY" 
		"ManRN.placeHolderList[575]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.translateZ" 
		"ManRN.placeHolderList[576]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.rotateX" 
		"ManRN.placeHolderList[577]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.rotateY" 
		"ManRN.placeHolderList[578]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L.rotateZ" 
		"ManRN.placeHolderList[579]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.translateX" 
		"ManRN.placeHolderList[580]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.translateY" 
		"ManRN.placeHolderList[581]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.translateZ" 
		"ManRN.placeHolderList[582]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.rotateX" 
		"ManRN.placeHolderList[583]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.rotateY" 
		"ManRN.placeHolderList[584]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L.rotateZ" 
		"ManRN.placeHolderList[585]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.translateX" 
		"ManRN.placeHolderList[586]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.translateY" 
		"ManRN.placeHolderList[587]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.translateZ" 
		"ManRN.placeHolderList[588]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.rotateX" 
		"ManRN.placeHolderList[589]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.rotateY" 
		"ManRN.placeHolderList[590]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L.rotateZ" 
		"ManRN.placeHolderList[591]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.translateX" 
		"ManRN.placeHolderList[592]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.translateY" 
		"ManRN.placeHolderList[593]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.translateZ" 
		"ManRN.placeHolderList[594]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.rotateX" 
		"ManRN.placeHolderList[595]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.rotateY" 
		"ManRN.placeHolderList[596]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetRingFinger1_L|Man:SDKFKRingFinger1_L|Man:FKExtraRingFinger1_L|Man:FKRingFinger1_L|Man:FKXRingFinger1_L|Man:FKOffsetRingFinger2_L|Man:SDKFKRingFinger2_L|Man:FKExtraRingFinger2_L|Man:FKRingFinger2_L|Man:FKXRingFinger2_L|Man:FKOffsetRingFinger3_L|Man:SDKFKRingFinger3_L|Man:FKExtraRingFinger3_L|Man:FKRingFinger3_L.rotateZ" 
		"ManRN.placeHolderList[597]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.translateX" 
		"ManRN.placeHolderList[598]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.translateY" 
		"ManRN.placeHolderList[599]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.translateZ" 
		"ManRN.placeHolderList[600]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.rotateX" 
		"ManRN.placeHolderList[601]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.rotateY" 
		"ManRN.placeHolderList[602]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L.rotateZ" 
		"ManRN.placeHolderList[603]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.translateX" 
		"ManRN.placeHolderList[604]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.translateY" 
		"ManRN.placeHolderList[605]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.translateZ" 
		"ManRN.placeHolderList[606]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.rotateX" 
		"ManRN.placeHolderList[607]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.rotateY" 
		"ManRN.placeHolderList[608]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L.rotateZ" 
		"ManRN.placeHolderList[609]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.translateX" 
		"ManRN.placeHolderList[610]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.translateY" 
		"ManRN.placeHolderList[611]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.translateZ" 
		"ManRN.placeHolderList[612]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.rotateX" 
		"ManRN.placeHolderList[613]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.rotateY" 
		"ManRN.placeHolderList[614]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L.rotateZ" 
		"ManRN.placeHolderList[615]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.translateX" 
		"ManRN.placeHolderList[616]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.translateY" 
		"ManRN.placeHolderList[617]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.translateZ" 
		"ManRN.placeHolderList[618]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.rotateX" 
		"ManRN.placeHolderList[619]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.rotateY" 
		"ManRN.placeHolderList[620]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L.rotateZ" 
		"ManRN.placeHolderList[621]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.translateX" 
		"ManRN.placeHolderList[622]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.translateY" 
		"ManRN.placeHolderList[623]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.translateZ" 
		"ManRN.placeHolderList[624]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.rotateX" 
		"ManRN.placeHolderList[625]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.rotateY" 
		"ManRN.placeHolderList[626]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L.rotateZ" 
		"ManRN.placeHolderList[627]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.translateX" 
		"ManRN.placeHolderList[628]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.translateY" 
		"ManRN.placeHolderList[629]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.translateZ" 
		"ManRN.placeHolderList[630]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.rotateX" 
		"ManRN.placeHolderList[631]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.rotateY" 
		"ManRN.placeHolderList[632]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToWrist_L|Man:FKOffsetPinkyFinger1_L|Man:SDKFKPinkyFinger1_L|Man:FKExtraPinkyFinger1_L|Man:FKPinkyFinger1_L|Man:FKXPinkyFinger1_L|Man:FKOffsetPinkyFinger2_L|Man:SDKFKPinkyFinger2_L|Man:FKExtraPinkyFinger2_L|Man:FKPinkyFinger2_L|Man:FKXPinkyFinger2_L|Man:FKOffsetPinkyFinger3_L|Man:SDKFKPinkyFinger3_L|Man:FKExtraPinkyFinger3_L|Man:FKPinkyFinger3_L.rotateZ" 
		"ManRN.placeHolderList[633]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.translateX" 
		"ManRN.placeHolderList[634]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.translateY" 
		"ManRN.placeHolderList[635]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.translateZ" 
		"ManRN.placeHolderList[636]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.rotateX" 
		"ManRN.placeHolderList[637]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.rotateY" 
		"ManRN.placeHolderList[638]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L.rotateZ" 
		"ManRN.placeHolderList[639]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.translateX" 
		"ManRN.placeHolderList[640]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.translateY" 
		"ManRN.placeHolderList[641]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.translateZ" 
		"ManRN.placeHolderList[642]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.rotateX" 
		"ManRN.placeHolderList[643]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.rotateY" 
		"ManRN.placeHolderList[644]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L.rotateZ" 
		"ManRN.placeHolderList[645]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.translateX" 
		"ManRN.placeHolderList[646]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.translateY" 
		"ManRN.placeHolderList[647]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.translateZ" 
		"ManRN.placeHolderList[648]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.rotateX" 
		"ManRN.placeHolderList[649]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.rotateY" 
		"ManRN.placeHolderList[650]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L.rotateZ" 
		"ManRN.placeHolderList[651]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.translateX" 
		"ManRN.placeHolderList[652]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.translateY" 
		"ManRN.placeHolderList[653]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.translateZ" 
		"ManRN.placeHolderList[654]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.rotateX" 
		"ManRN.placeHolderList[655]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.rotateY" 
		"ManRN.placeHolderList[656]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L.rotateZ" 
		"ManRN.placeHolderList[657]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.translateX" 
		"ManRN.placeHolderList[658]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.translateY" 
		"ManRN.placeHolderList[659]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.translateZ" 
		"ManRN.placeHolderList[660]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.rotateX" 
		"ManRN.placeHolderList[661]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.rotateY" 
		"ManRN.placeHolderList[662]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L.rotateZ" 
		"ManRN.placeHolderList[663]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.translateX" 
		"ManRN.placeHolderList[664]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.translateY" 
		"ManRN.placeHolderList[665]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.translateZ" 
		"ManRN.placeHolderList[666]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.rotateX" 
		"ManRN.placeHolderList[667]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.rotateY" 
		"ManRN.placeHolderList[668]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKSystem|Man:FKParentConstraintToScapula_L|Man:FKOffsetShoulder_L|Man:FKExtraShoulder_L|Man:FKShoulder_L|Man:FKXShoulder_L|Man:FKOffsetElbow_L|Man:FKExtraElbow_L|Man:FKElbow_L|Man:FKXElbow_L|Man:FKOffsetWrist_L|Man:FKExtraWrist_L|Man:FKWrist_L.rotateZ" 
		"ManRN.placeHolderList[669]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.translateX" 
		"ManRN.placeHolderList[670]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.translateY" 
		"ManRN.placeHolderList[671]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.translateZ" 
		"ManRN.placeHolderList[672]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.rotateX" 
		"ManRN.placeHolderList[673]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.rotateY" 
		"ManRN.placeHolderList[674]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R.rotateZ" 
		"ManRN.placeHolderList[675]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.translateX" 
		"ManRN.placeHolderList[676]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.translateY" 
		"ManRN.placeHolderList[677]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.translateZ" 
		"ManRN.placeHolderList[678]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.rotateY" 
		"ManRN.placeHolderList[679]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.rotateZ" 
		"ManRN.placeHolderList[680]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_R|Man:IKExtraArm_R|Man:IKArm_R.rotateX" 
		"ManRN.placeHolderList[681]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.translateX" 
		"ManRN.placeHolderList[682]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.translateY" 
		"ManRN.placeHolderList[683]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.translateZ" 
		"ManRN.placeHolderList[684]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.rotateX" 
		"ManRN.placeHolderList[685]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.rotateY" 
		"ManRN.placeHolderList[686]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R.rotateZ" 
		"ManRN.placeHolderList[687]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.translateX" 
		"ManRN.placeHolderList[688]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.translateY" 
		"ManRN.placeHolderList[689]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.translateZ" 
		"ManRN.placeHolderList[690]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.rotateY" 
		"ManRN.placeHolderList[691]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.rotateZ" 
		"ManRN.placeHolderList[692]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R.rotateX" 
		"ManRN.placeHolderList[693]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.translateX" 
		"ManRN.placeHolderList[694]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.translateY" 
		"ManRN.placeHolderList[695]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.translateZ" 
		"ManRN.placeHolderList[696]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.rotateX" 
		"ManRN.placeHolderList[697]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.rotateY" 
		"ManRN.placeHolderList[698]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R.rotateZ" 
		"ManRN.placeHolderList[699]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.translateX" 
		"ManRN.placeHolderList[700]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.translateY" 
		"ManRN.placeHolderList[701]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.translateZ" 
		"ManRN.placeHolderList[702]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.rotateX" 
		"ManRN.placeHolderList[703]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.rotateY" 
		"ManRN.placeHolderList[704]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R.rotateZ" 
		"ManRN.placeHolderList[705]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.translateX" 
		"ManRN.placeHolderList[706]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.translateY" 
		"ManRN.placeHolderList[707]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.translateZ" 
		"ManRN.placeHolderList[708]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.rotateX" 
		"ManRN.placeHolderList[709]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.rotateY" 
		"ManRN.placeHolderList[710]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R.rotateZ" 
		"ManRN.placeHolderList[711]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.translateX" 
		"ManRN.placeHolderList[712]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.translateY" 
		"ManRN.placeHolderList[713]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.translateZ" 
		"ManRN.placeHolderList[714]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.rotateX" 
		"ManRN.placeHolderList[715]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.rotateY" 
		"ManRN.placeHolderList[716]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R.rotateZ" 
		"ManRN.placeHolderList[717]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.translateX" 
		"ManRN.placeHolderList[718]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.translateY" 
		"ManRN.placeHolderList[719]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.translateZ" 
		"ManRN.placeHolderList[720]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.rotateX" 
		"ManRN.placeHolderList[721]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.rotateY" 
		"ManRN.placeHolderList[722]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R.rotateZ" 
		"ManRN.placeHolderList[723]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.translateX" 
		"ManRN.placeHolderList[724]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.translateY" 
		"ManRN.placeHolderList[725]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.translateZ" 
		"ManRN.placeHolderList[726]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.rotateX" 
		"ManRN.placeHolderList[727]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.rotateY" 
		"ManRN.placeHolderList[728]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:RollOffsetToes_R|Man:RollRollerToes_R|Man:RollExtraToes_R|Man:RollToes_R.rotateZ" 
		"ManRN.placeHolderList[729]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.translateX" 
		"ManRN.placeHolderList[730]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.translateY" 
		"ManRN.placeHolderList[731]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.translateZ" 
		"ManRN.placeHolderList[732]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.rotateX" 
		"ManRN.placeHolderList[733]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.rotateY" 
		"ManRN.placeHolderList[734]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R.rotateZ" 
		"ManRN.placeHolderList[735]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.translateX" 
		"ManRN.placeHolderList[736]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.translateY" 
		"ManRN.placeHolderList[737]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.translateZ" 
		"ManRN.placeHolderList[738]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.rotateX" 
		"ManRN.placeHolderList[739]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.rotateY" 
		"ManRN.placeHolderList[740]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_R|Man:IKExtraLeg_R|Man:IKLeg_R|Man:RollOffsetHeel_R|Man:RollRollerHeel_R|Man:RollExtraHeel_R|Man:RollHeel_R|Man:RollOffsetToesEnd_R|Man:RollRollerToesEnd_R|Man:RollExtraToesEnd_R|Man:RollToesEnd_R|Man:IKOffsetToes_R|Man:IKExtraToes_R|Man:IKToes_R.rotateZ" 
		"ManRN.placeHolderList[741]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.translateX" 
		"ManRN.placeHolderList[742]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.translateY" 
		"ManRN.placeHolderList[743]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.translateZ" 
		"ManRN.placeHolderList[744]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.rotateX" 
		"ManRN.placeHolderList[745]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.rotateY" 
		"ManRN.placeHolderList[746]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L.rotateZ" 
		"ManRN.placeHolderList[747]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.translateX" 
		"ManRN.placeHolderList[748]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.translateY" 
		"ManRN.placeHolderList[749]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.translateZ" 
		"ManRN.placeHolderList[750]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.rotateY" 
		"ManRN.placeHolderList[751]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.rotateZ" 
		"ManRN.placeHolderList[752]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetArm_L|Man:IKExtraArm_L|Man:IKArm_L.rotateX" 
		"ManRN.placeHolderList[753]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.translateX" 
		"ManRN.placeHolderList[754]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.translateY" 
		"ManRN.placeHolderList[755]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.translateZ" 
		"ManRN.placeHolderList[756]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.rotateX" 
		"ManRN.placeHolderList[757]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.rotateY" 
		"ManRN.placeHolderList[758]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L.rotateZ" 
		"ManRN.placeHolderList[759]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.translateX" 
		"ManRN.placeHolderList[760]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.translateY" 
		"ManRN.placeHolderList[761]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.translateZ" 
		"ManRN.placeHolderList[762]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.rotateX" 
		"ManRN.placeHolderList[763]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.rotateY" 
		"ManRN.placeHolderList[764]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L.rotateZ" 
		"ManRN.placeHolderList[765]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.translateX" 
		"ManRN.placeHolderList[766]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.translateY" 
		"ManRN.placeHolderList[767]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.translateZ" 
		"ManRN.placeHolderList[768]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.rotateX" 
		"ManRN.placeHolderList[769]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.rotateY" 
		"ManRN.placeHolderList[770]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L.rotateZ" 
		"ManRN.placeHolderList[771]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.translateX" 
		"ManRN.placeHolderList[772]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.translateY" 
		"ManRN.placeHolderList[773]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.translateZ" 
		"ManRN.placeHolderList[774]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.rotateX" 
		"ManRN.placeHolderList[775]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.rotateY" 
		"ManRN.placeHolderList[776]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L.rotateZ" 
		"ManRN.placeHolderList[777]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.translateX" 
		"ManRN.placeHolderList[778]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.translateY" 
		"ManRN.placeHolderList[779]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.translateZ" 
		"ManRN.placeHolderList[780]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.rotateX" 
		"ManRN.placeHolderList[781]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.rotateY" 
		"ManRN.placeHolderList[782]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L.rotateZ" 
		"ManRN.placeHolderList[783]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.translateX" 
		"ManRN.placeHolderList[784]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.translateY" 
		"ManRN.placeHolderList[785]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.translateZ" 
		"ManRN.placeHolderList[786]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.rotateX" 
		"ManRN.placeHolderList[787]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.rotateY" 
		"ManRN.placeHolderList[788]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L.rotateZ" 
		"ManRN.placeHolderList[789]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.translateX" 
		"ManRN.placeHolderList[790]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.translateY" 
		"ManRN.placeHolderList[791]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.translateZ" 
		"ManRN.placeHolderList[792]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.rotateX" 
		"ManRN.placeHolderList[793]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.rotateY" 
		"ManRN.placeHolderList[794]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L.rotateZ" 
		"ManRN.placeHolderList[795]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.translateX" 
		"ManRN.placeHolderList[796]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.translateY" 
		"ManRN.placeHolderList[797]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.translateZ" 
		"ManRN.placeHolderList[798]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.rotateX" 
		"ManRN.placeHolderList[799]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.rotateY" 
		"ManRN.placeHolderList[800]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:RollOffsetToes_L|Man:RollRollerToes_L|Man:RollExtraToes_L|Man:RollToes_L.rotateZ" 
		"ManRN.placeHolderList[801]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.translateX" 
		"ManRN.placeHolderList[802]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.translateY" 
		"ManRN.placeHolderList[803]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.translateZ" 
		"ManRN.placeHolderList[804]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.rotateX" 
		"ManRN.placeHolderList[805]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.rotateY" 
		"ManRN.placeHolderList[806]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L.rotateZ" 
		"ManRN.placeHolderList[807]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.translateX" 
		"ManRN.placeHolderList[808]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.translateY" 
		"ManRN.placeHolderList[809]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.translateZ" 
		"ManRN.placeHolderList[810]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.rotateX" 
		"ManRN.placeHolderList[811]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.rotateY" 
		"ManRN.placeHolderList[812]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKHandleFollowMain|Man:IKOffsetLeg_L|Man:IKExtraLeg_L|Man:IKLeg_L|Man:RollOffsetHeel_L|Man:RollRollerHeel_L|Man:RollExtraHeel_L|Man:RollHeel_L|Man:RollOffsetToesEnd_L|Man:RollRollerToesEnd_L|Man:RollExtraToesEnd_L|Man:RollToesEnd_L|Man:IKOffsetToes_L|Man:IKExtraToes_L|Man:IKToes_L.rotateZ" 
		"ManRN.placeHolderList[813]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.translateX" 
		"ManRN.placeHolderList[814]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.translateY" 
		"ManRN.placeHolderList[815]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.translateZ" 
		"ManRN.placeHolderList[816]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.rotateX" 
		"ManRN.placeHolderList[817]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.rotateY" 
		"ManRN.placeHolderList[818]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R.rotateZ" 
		"ManRN.placeHolderList[819]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R|Man:PoleArm_R.translateX" 
		"ManRN.placeHolderList[820]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R|Man:PoleArm_R.translateY" 
		"ManRN.placeHolderList[821]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_R|Man:PoleExtraArm_R|Man:PoleArm_R.translateZ" 
		"ManRN.placeHolderList[822]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.translateX" 
		"ManRN.placeHolderList[823]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.translateY" 
		"ManRN.placeHolderList[824]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.translateZ" 
		"ManRN.placeHolderList[825]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.rotateX" 
		"ManRN.placeHolderList[826]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.rotateY" 
		"ManRN.placeHolderList[827]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M.rotateZ" 
		"ManRN.placeHolderList[828]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M|Man:IKcvSpine1_M.translateZ" 
		"ManRN.placeHolderList[829]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M|Man:IKcvSpine1_M.translateX" 
		"ManRN.placeHolderList[830]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine1_M|Man:IKExtracvSpine1_M|Man:IKcvSpine1_M.translateY" 
		"ManRN.placeHolderList[831]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.translateX" 
		"ManRN.placeHolderList[832]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.translateY" 
		"ManRN.placeHolderList[833]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.translateZ" 
		"ManRN.placeHolderList[834]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.rotateX" 
		"ManRN.placeHolderList[835]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.rotateY" 
		"ManRN.placeHolderList[836]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M.rotateZ" 
		"ManRN.placeHolderList[837]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M|Man:IKcvSpine2_M.translateZ" 
		"ManRN.placeHolderList[838]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M|Man:IKcvSpine2_M.translateX" 
		"ManRN.placeHolderList[839]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetcvSpine2_M|Man:IKExtracvSpine2_M|Man:IKcvSpine2_M.translateY" 
		"ManRN.placeHolderList[840]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.translateX" 
		"ManRN.placeHolderList[841]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.translateY" 
		"ManRN.placeHolderList[842]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.translateZ" 
		"ManRN.placeHolderList[843]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.rotateX" 
		"ManRN.placeHolderList[844]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.rotateY" 
		"ManRN.placeHolderList[845]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M.rotateZ" 
		"ManRN.placeHolderList[846]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.translateX" 
		"ManRN.placeHolderList[847]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.translateY" 
		"ManRN.placeHolderList[848]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.translateZ" 
		"ManRN.placeHolderList[849]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.rotateX" 
		"ManRN.placeHolderList[850]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.rotateY" 
		"ManRN.placeHolderList[851]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetSpine2_M|Man:IKExtraSpine2_M|Man:IKSpine2_M.rotateZ" 
		"ManRN.placeHolderList[852]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.translateX" 
		"ManRN.placeHolderList[853]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.translateY" 
		"ManRN.placeHolderList[854]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.translateZ" 
		"ManRN.placeHolderList[855]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.rotateX" 
		"ManRN.placeHolderList[856]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.rotateY" 
		"ManRN.placeHolderList[857]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M.rotateZ" 
		"ManRN.placeHolderList[858]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.translateX" 
		"ManRN.placeHolderList[859]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.translateY" 
		"ManRN.placeHolderList[860]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.translateZ" 
		"ManRN.placeHolderList[861]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.rotateX" 
		"ManRN.placeHolderList[862]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.rotateY" 
		"ManRN.placeHolderList[863]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKOffsetSpine1_M|Man:IKExtraSpine1_M|Man:IKSpine1_M.rotateZ" 
		"ManRN.placeHolderList[864]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.translateX" 
		"ManRN.placeHolderList[865]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.translateY" 
		"ManRN.placeHolderList[866]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.translateZ" 
		"ManRN.placeHolderList[867]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.rotateX" 
		"ManRN.placeHolderList[868]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.rotateY" 
		"ManRN.placeHolderList[869]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M.rotateZ" 
		"ManRN.placeHolderList[870]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.translateX" 
		"ManRN.placeHolderList[871]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.translateY" 
		"ManRN.placeHolderList[872]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.translateZ" 
		"ManRN.placeHolderList[873]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.rotateX" 
		"ManRN.placeHolderList[874]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.rotateY" 
		"ManRN.placeHolderList[875]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M.rotateZ" 
		"ManRN.placeHolderList[876]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.translateX" 
		"ManRN.placeHolderList[877]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.translateY" 
		"ManRN.placeHolderList[878]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.translateZ" 
		"ManRN.placeHolderList[879]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.rotateX" 
		"ManRN.placeHolderList[880]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.rotateY" 
		"ManRN.placeHolderList[881]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M.rotateZ" 
		"ManRN.placeHolderList[882]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.translateX" 
		"ManRN.placeHolderList[883]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.translateY" 
		"ManRN.placeHolderList[884]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.translateZ" 
		"ManRN.placeHolderList[885]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.rotateX" 
		"ManRN.placeHolderList[886]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.rotateY" 
		"ManRN.placeHolderList[887]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M.rotateZ" 
		"ManRN.placeHolderList[888]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.translateX" 
		"ManRN.placeHolderList[889]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.translateY" 
		"ManRN.placeHolderList[890]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.translateZ" 
		"ManRN.placeHolderList[891]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.rotateX" 
		"ManRN.placeHolderList[892]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.rotateY" 
		"ManRN.placeHolderList[893]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M.rotateZ" 
		"ManRN.placeHolderList[894]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.translateX" 
		"ManRN.placeHolderList[895]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.translateY" 
		"ManRN.placeHolderList[896]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.translateZ" 
		"ManRN.placeHolderList[897]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.rotateX" 
		"ManRN.placeHolderList[898]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.rotateY" 
		"ManRN.placeHolderList[899]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M.rotateZ" 
		"ManRN.placeHolderList[900]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.translateX" 
		"ManRN.placeHolderList[901]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.translateY" 
		"ManRN.placeHolderList[902]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.translateZ" 
		"ManRN.placeHolderList[903]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.rotateX" 
		"ManRN.placeHolderList[904]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.rotateY" 
		"ManRN.placeHolderList[905]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M.rotateZ" 
		"ManRN.placeHolderList[906]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.translateX" 
		"ManRN.placeHolderList[907]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.translateY" 
		"ManRN.placeHolderList[908]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.translateZ" 
		"ManRN.placeHolderList[909]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.rotateX" 
		"ManRN.placeHolderList[910]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.rotateY" 
		"ManRN.placeHolderList[911]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:IKOffsetConstrainedSpine1_M|Man:IKhybridOffsetSpine1_M|Man:IKhybridFollowSpine1_M|Man:IKhybridExtraSpine1_M|Man:IKhybridSpine1_M|Man:IKhybridOffsetSpine2_M|Man:IKhybridExtraSpine2_M|Man:IKhybridSpine2_M|Man:IKhybridOffsetSpine3_M|Man:IKhybridExtraSpine3_M|Man:IKhybridSpine3_M|Man:IKOffsetSpine3_M|Man:IKExtraSpine3_M|Man:IKSpine3_M.rotateZ" 
		"ManRN.placeHolderList[912]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.translateX" 
		"ManRN.placeHolderList[913]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.translateY" 
		"ManRN.placeHolderList[914]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.translateZ" 
		"ManRN.placeHolderList[915]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.rotateX" 
		"ManRN.placeHolderList[916]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.rotateY" 
		"ManRN.placeHolderList[917]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R.rotateZ" 
		"ManRN.placeHolderList[918]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R|Man:PoleLeg_R.translateX" 
		"ManRN.placeHolderList[919]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R|Man:PoleLeg_R.translateY" 
		"ManRN.placeHolderList[920]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_R|Man:PoleExtraLeg_R|Man:PoleLeg_R.translateZ" 
		"ManRN.placeHolderList[921]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.translateX" 
		"ManRN.placeHolderList[922]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.translateY" 
		"ManRN.placeHolderList[923]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.translateZ" 
		"ManRN.placeHolderList[924]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.rotateX" 
		"ManRN.placeHolderList[925]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.rotateY" 
		"ManRN.placeHolderList[926]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L.rotateZ" 
		"ManRN.placeHolderList[927]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L|Man:PoleArm_L.translateX" 
		"ManRN.placeHolderList[928]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L|Man:PoleArm_L.translateY" 
		"ManRN.placeHolderList[929]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetArm_L|Man:PoleExtraArm_L|Man:PoleArm_L.translateZ" 
		"ManRN.placeHolderList[930]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.translateX" 
		"ManRN.placeHolderList[931]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.translateY" 
		"ManRN.placeHolderList[932]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.translateZ" 
		"ManRN.placeHolderList[933]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.rotateX" 
		"ManRN.placeHolderList[934]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.rotateY" 
		"ManRN.placeHolderList[935]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L.rotateZ" 
		"ManRN.placeHolderList[936]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L|Man:PoleLeg_L.translateX" 
		"ManRN.placeHolderList[937]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L|Man:PoleLeg_L.translateY" 
		"ManRN.placeHolderList[938]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:IKSystem|Man:IKHandle|Man:PoleOffsetLeg_L|Man:PoleExtraLeg_L|Man:PoleLeg_L.translateZ" 
		"ManRN.placeHolderList[939]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_R|Man:FKIKArm_R.FKIKBlend" 
		"ManRN.placeHolderList[940]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_R|Man:FKIKLeg_R.FKIKBlend" 
		"ManRN.placeHolderList[941]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintSpine_M|Man:FKIKSpine_M.FKIKBlend" 
		"ManRN.placeHolderList[942]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintArm_L|Man:FKIKArm_L.FKIKBlend" 
		"ManRN.placeHolderList[943]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:FKIKSystem|Man:FKIKParentConstraintLeg_L|Man:FKIKLeg_L.FKIKBlend" 
		"ManRN.placeHolderList[944]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.translateX" 
		"ManRN.placeHolderList[945]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.translateY" 
		"ManRN.placeHolderList[946]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.translateZ" 
		"ManRN.placeHolderList[947]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.rotateX" 
		"ManRN.placeHolderList[948]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.rotateY" 
		"ManRN.placeHolderList[949]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M.rotateZ" 
		"ManRN.placeHolderList[950]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_R|Man:AimEye_R.translateX" 
		"ManRN.placeHolderList[951]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_R|Man:AimEye_R.translateY" 
		"ManRN.placeHolderList[952]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_R|Man:AimEye_R.translateZ" 
		"ManRN.placeHolderList[953]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_L|Man:AimEye_L.translateX" 
		"ManRN.placeHolderList[954]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_L|Man:AimEye_L.translateY" 
		"ManRN.placeHolderList[955]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:AimSystem|Man:AimEye|Man:AimOffsetEye|Man:AimFollowEye|Man:AimEye_M|Man:AimOffsetEye_L|Man:AimEye_L.translateZ" 
		"ManRN.placeHolderList[956]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.translateX" 
		"ManRN.placeHolderList[957]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.translateY" 
		"ManRN.placeHolderList[958]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.translateZ" 
		"ManRN.placeHolderList[959]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.rotateX" 
		"ManRN.placeHolderList[960]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.rotateY" 
		"ManRN.placeHolderList[961]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M.rotateZ" 
		"ManRN.placeHolderList[962]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.translateX" 
		"ManRN.placeHolderList[963]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.translateY" 
		"ManRN.placeHolderList[964]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.translateZ" 
		"ManRN.placeHolderList[965]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.rotateX" 
		"ManRN.placeHolderList[966]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.rotateY" 
		"ManRN.placeHolderList[967]" ""
		5 4 "ManRN" "|Man:Group|Man:MotionSystem|Man:RootSystem|Man:RootCenterBtwLegsBlended_M|Man:RootOffsetX_M|Man:RootExtraX_M|Man:RootX_M.rotateZ" 
		"ManRN.placeHolderList[968]" "";
	setAttr ".ptag" -type "string" "";
lockNode -l 1 ;
createNode animCurveTL -n "IKLeg_L_translateX";
	rename -uid "5B19C96F-453D-8ADD-07AA-D79F96087425";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 0;
createNode animCurveTL -n "IKLeg_L_translateY";
	rename -uid "1D796608-4033-DC30-53F6-0E900B0819D9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 50.384717391662861;
createNode animCurveTL -n "IKLeg_L_translateZ";
	rename -uid "AFCC6902-48B3-E4EF-A366-32A53D492015";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 26.952445773811785;
createNode animCurveTA -n "IKLeg_L_rotateX";
	rename -uid "0C5CC7BB-4467-6370-6873-F9870AB9FD2C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 45.257485991003655;
createNode animCurveTA -n "IKLeg_L_rotateY";
	rename -uid "BAE90624-4E37-B59B-9E33-A7A5C7B0272E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 0;
createNode animCurveTA -n "IKLeg_L_rotateZ";
	rename -uid "0947A5D4-4B96-15BD-48A8-CE9440329F55";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  105 0 106 0 145 0;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "B56043F2-4FB3-2D26-FE2A-F0ACA464D713";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $nodeEditorPanelVisible = stringArrayContains(\"nodeEditorPanel1\", `getPanel -vis`);\n\tint    $nodeEditorWorkspaceControlOpen = (`workspaceControl -exists nodeEditorPanel1Window` && `workspaceControl -q -visible nodeEditorPanel1Window`);\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\n\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -docTag \"RADRENDER\" \n            -editorChanged \"CgAbBlastPanelOptChangeCallback\" \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n"
		+ "            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n"
		+ "            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n"
		+ "            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -docTag \"RADRENDER\" \n            -editorChanged \"CgAbBlastPanelOptChangeCallback\" \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n"
		+ "            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n"
		+ "            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n"
		+ "            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -docTag \"RADRENDER\" \n            -editorChanged \"CgAbBlastPanelOptChangeCallback\" \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n"
		+ "            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n"
		+ "            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n"
		+ "            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -docTag \"RADRENDER\" \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n"
		+ "            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n"
		+ "            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 876\n            -height 710\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"ToggledOutliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"ToggledOutliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n"
		+ "            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -isSet 0\n            -isSetMember 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n"
		+ "            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n"
		+ "            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -isSet 0\n            -isSetMember 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n"
		+ "            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n"
		+ "                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n"
		+ "                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 1\n                -autoFitTime 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n                -showCurveNames 0\n                -showActiveCurveNames 0\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n"
		+ "                -constrainDrag 0\n                -classicMode 1\n                -valueLinesToggle 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n"
		+ "                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -autoFitTime 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n"
		+ "                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"timeEditorPanel\" (localizedPanelLabel(\"Time Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Time Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -autoFitTime 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n"
		+ "                -autoFit 0\n                -autoFitTime 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n"
		+ "                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif ($nodeEditorPanelVisible || $nodeEditorWorkspaceControlOpen) {\n\t\tif (\"\" == $panelName) {\n\t\t\tif ($useSceneConfig) {\n\t\t\t\t$panelName = `scriptedPanel -unParent  -type \"nodeEditorPanel\" -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels `;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n"
		+ "                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -defaultPinnedState 0\n                -additiveGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -editorMode \"default\" \n                $editorName;\n\t\t\t}\n\t\t} else {\n\t\t\t$label = `panel -q -label $panelName`;\n\t\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n"
		+ "            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -copyConnectionsOnPaste 0\n                -defaultPinnedState 0\n                -additiveGraphingMode 1\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -editorMode \"default\" \n"
		+ "                $editorName;\n\t\t\tif (!$useSceneConfig) {\n\t\t\t\tpanel -e -l $label $panelName;\n\t\t\t}\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"shapePanel\" (localizedPanelLabel(\"Shape Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tshapePanel -edit -l (localizedPanelLabel(\"Shape Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"posePanel\" (localizedPanelLabel(\"Pose Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tposePanel -edit -l (localizedPanelLabel(\"Pose Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"contentBrowserPanel\" (localizedPanelLabel(\"Content Browser\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Content Browser\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"Stereo\" (localizedPanelLabel(\"Stereo\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Stereo\")) -mbv $menusOkayInPanels  $panelName;\nstring $editorName = ($panelName+\"Editor\");\n            stereoCameraView -e \n                -editorChanged \"updateModelPanelBar\" \n                -camera \"persp\" \n                -useInteractiveMode 0\n                -displayLights \"default\" \n                -displayAppearance \"smoothShaded\" \n                -activeOnly 0\n                -ignorePanZoom 0\n"
		+ "                -wireframeOnShaded 0\n                -headsUpDisplay 1\n                -holdOuts 1\n                -selectionHiliteDisplay 1\n                -useDefaultMaterial 0\n                -bufferMode \"double\" \n                -twoSidedLighting 0\n                -backfaceCulling 0\n                -xray 0\n                -jointXray 0\n                -activeComponentsXray 0\n                -displayTextures 0\n                -smoothWireframe 0\n                -lineWidth 1\n                -textureAnisotropic 0\n                -textureHilight 1\n                -textureSampling 2\n                -textureDisplay \"modulate\" \n                -textureMaxSize 16384\n                -fogging 0\n                -fogSource \"fragment\" \n                -fogMode \"linear\" \n                -fogStart 0\n                -fogEnd 100\n                -fogDensity 0.1\n                -fogColor 0.5 0.5 0.5 1 \n                -depthOfFieldPreview 1\n                -maxConstantTransparency 1\n                -objectFilterShowInHUD 1\n                -isFiltered 0\n"
		+ "                -colorResolution 4 4 \n                -bumpResolution 4 4 \n                -textureCompression 0\n                -transparencyAlgorithm \"frontAndBackCull\" \n                -transpInShadows 0\n                -cullingOverride \"none\" \n                -lowQualityLighting 0\n                -maximumNumHardwareLights 0\n                -occlusionCulling 0\n                -shadingModel 0\n                -useBaseRenderer 0\n                -useReducedRenderer 0\n                -smallObjectCulling 0\n                -smallObjectThreshold -1 \n                -interactiveDisableShadows 0\n                -interactiveBackFaceCull 0\n                -sortTransparent 1\n                -controllers 1\n                -nurbsCurves 1\n                -nurbsSurfaces 1\n                -polymeshes 1\n                -subdivSurfaces 1\n                -planes 1\n                -lights 1\n                -cameras 1\n                -controlVertices 1\n                -hulls 1\n                -grid 1\n                -imagePlane 1\n"
		+ "                -joints 1\n                -ikHandles 1\n                -deformers 1\n                -dynamics 1\n                -particleInstancers 1\n                -fluids 1\n                -hairSystems 1\n                -follicles 1\n                -nCloths 1\n                -nParticles 1\n                -nRigids 1\n                -dynamicConstraints 1\n                -locators 1\n                -manipulators 1\n                -pluginShapes 1\n                -dimensions 1\n                -handles 1\n                -pivots 1\n                -textures 1\n                -strokes 1\n                -motionTrails 1\n                -clipGhosts 1\n                -greasePencils 1\n                -shadows 0\n                -captureSequenceNumber -1\n                -width 0\n                -height 0\n                -sceneRenderFilter 0\n                -displayMode \"centerEye\" \n                -viewColor 0 0 0 1 \n                -useCustomBackground 1\n                $editorName;\n            stereoCameraView -e -viewSelected 0 $editorName;\n"
		+ "            stereoCameraView -e \n                -pluginObjects \"gpuCacheDisplayFilter\" 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"ModelPanel\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"ModelPanel\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 0\n            -holdOuts 1\n            -selectionHiliteDisplay 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n"
		+ "            -displayTextures 1\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n"
		+ "            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 0\n            -nurbsCurves 0\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 0\n            -lights 0\n            -cameras 0\n            -controlVertices 0\n            -hulls 0\n            -grid 0\n            -imagePlane 0\n            -joints 0\n            -ikHandles 0\n            -deformers 0\n            -dynamics 0\n            -particleInstancers 0\n            -fluids 0\n            -hairSystems 0\n            -follicles 0\n            -nCloths 0\n            -nParticles 0\n            -nRigids 0\n            -dynamicConstraints 0\n            -locators 0\n            -manipulators 0\n            -pluginShapes 0\n            -dimensions 0\n            -handles 0\n            -pivots 0\n            -textures 0\n            -strokes 0\n"
		+ "            -motionTrails 0\n            -clipGhosts 0\n            -greasePencils 0\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 351\n            -height 331\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 0 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"ModelPanel\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"ModelPanel\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 0\n"
		+ "            -holdOuts 1\n            -selectionHiliteDisplay 0\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 1\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n"
		+ "            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 0\n            -nurbsCurves 0\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 0\n            -lights 0\n            -cameras 0\n            -controlVertices 0\n            -hulls 0\n            -grid 0\n            -imagePlane 0\n            -joints 0\n            -ikHandles 0\n            -deformers 0\n            -dynamics 0\n            -particleInstancers 0\n            -fluids 0\n            -hairSystems 0\n            -follicles 0\n            -nCloths 0\n            -nParticles 0\n            -nRigids 0\n"
		+ "            -dynamicConstraints 0\n            -locators 0\n            -manipulators 0\n            -pluginShapes 0\n            -dimensions 0\n            -handles 0\n            -pivots 0\n            -textures 0\n            -strokes 0\n            -motionTrails 0\n            -clipGhosts 0\n            -greasePencils 0\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 351\n            -height 331\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 0 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-userCreated false\n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n"
		+ "\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -docTag \\\"RADRENDER\\\" \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 876\\n    -height 710\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -docTag \\\"RADRENDER\\\" \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 876\\n    -height 710\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 0 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "0FF16EB6-48D9-38AE-6FBA-03B74BE41428";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 40 -ast 1 -aet 40 ";
	setAttr ".st" 6;
createNode animCurveTA -n "FKExtraPinkyFinger1_R_rotateX";
	rename -uid "A3F8DDFB-439A-02B1-1EDD-AAB76E8CE71E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger1_R_rotateY";
	rename -uid "9ECC2651-47FC-9F94-C076-6BA76FD09A37";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger1_R_rotateZ";
	rename -uid "739186C5-4774-45CE-AA2D-D1BD7D51F7F1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger1_R_translateX";
	rename -uid "32CC9430-46B3-C140-A216-B585B7D81757";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -7.1054273579999998e-15 145 -7.1054273579999998e-15;
createNode animCurveTL -n "FKExtraPinkyFinger1_R_translateY";
	rename -uid "9BCD8D95-4D54-9639-9EF6-FBB23BCC00F2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger1_R_translateZ";
	rename -uid "134A5190-4A15-246C-11E7-94B29C7541BE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "FKSpine2_M_rotateX";
	rename -uid "A4BC498C-48E8-8A26-B6B5-56A5C3231F3D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKSpine2_M_rotateY";
	rename -uid "D5477FE1-4957-2287-C76F-4686306769C9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKSpine2_M_rotateZ";
	rename -uid "5D0B7B03-4E02-9DF2-7C1E-20AF58FA2EA4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine2_M_translateX";
	rename -uid "37499027-4C65-6555-864D-91AE21867C20";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine2_M_translateY";
	rename -uid "888B6C80-40AA-FB4C-F68C-7ABA3FEA7AF2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine2_M_translateZ";
	rename -uid "4F5940B1-4B56-B2B1-5260-DB8A49A98D1F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootX_M_rotateX";
	rename -uid "6CA60B33-4686-7026-7488-788680D660D2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootX_M_rotateY";
	rename -uid "AD6F2B58-449D-9D91-2D88-C69442160E38";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootX_M_rotateZ";
	rename -uid "2B51F03D-4DFE-E595-1025-F4A4444DF802";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootX_M_translateX";
	rename -uid "958EC242-43C9-D0D4-49A0-B0A31A2CB00B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootX_M_translateY";
	rename -uid "B560E243-4489-C981-28A0-9BB13D4568E0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootX_M_translateZ";
	rename -uid "60F77F5E-47E2-7D6D-3972-3DB428F240A4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger1_L_rotateX";
	rename -uid "978BB9D3-4F05-6DF2-717D-FB82FBD58F50";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger1_L_rotateY";
	rename -uid "B2A6D456-4B1E-E069-987A-5DA2A4C7C37E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger1_L_rotateZ";
	rename -uid "BEA55060-463A-AA19-A4A2-03BF64DD3E9F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger1_L_translateX";
	rename -uid "780F945C-499A-DCD3-0563-5E8099D9BB92";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger1_L_translateY";
	rename -uid "45091EB2-478A-A1B4-F7A5-E69AFEDA1829";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 8.8817841970012523e-16 145 8.8817841970012523e-16;
createNode animCurveTL -n "FKExtraPinkyFinger1_L_translateZ";
	rename -uid "5EADB3F9-49CC-0E9B-71B8-78A2A52722B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTU -n "FKIKArm_R_FKIKBlend";
	rename -uid "887F0D51-4384-D75D-A4D3-ED97C0547704";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKArm_L_rotateX";
	rename -uid "6EDF27F3-42A3-505D-8513-F2A11474CF54";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -7.5122312569464894e-38 145 -7.5122312569464894e-38;
createNode animCurveTA -n "IKArm_L_rotateY";
	rename -uid "D06A577D-4758-1543-391B-FABD2BC480BE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4033418597069738e-14 145 -1.4033418597069738e-14;
createNode animCurveTA -n "IKArm_L_rotateZ";
	rename -uid "5C0CE588-4BCD-2FDE-8BB0-AE9F269830D0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 6.1342023366874486e-22 145 6.1342023366874486e-22;
createNode animCurveTL -n "IKArm_L_translateX";
	rename -uid "79E7E2F9-491F-3A69-A969-70B018ED8036";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.8421709430404007e-14 145 2.8421709430404007e-14;
createNode animCurveTL -n "IKArm_L_translateY";
	rename -uid "644B0359-43E6-EA17-7EC8-B4AA1315740B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.9895196601282805e-13 145 1.9895196601282805e-13;
createNode animCurveTL -n "IKArm_L_translateZ";
	rename -uid "1D89C065-4C05-2D85-E2D1-0490DD402C3B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.2212453270876722e-15 145 1.2212453270876722e-15;
createNode animCurveTA -n "FKRoot_M_rotateX";
	rename -uid "F23F633F-4AE2-1DBF-D11B-869E2114750E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRoot_M_rotateY";
	rename -uid "96049A82-4DA1-CBAC-292D-8F8432D6825F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRoot_M_rotateZ";
	rename -uid "921C8845-4F7F-F290-6CF5-FB802C953D7C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRoot_M_translateX";
	rename -uid "6663EABC-455F-1236-AB59-C8AA85C728C5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRoot_M_translateY";
	rename -uid "34365982-453A-835F-5C4C-CA8F77A06181";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRoot_M_translateZ";
	rename -uid "66146A58-47E4-443D-FF3D-2EA53878A791";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_R_rotateX";
	rename -uid "F55951A5-4D70-B5AC-DD53-04B8623AE111";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_R_rotateY";
	rename -uid "92C07C78-4356-96BF-4177-6A9A3DD891C7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_R_rotateZ";
	rename -uid "B851E7E7-491B-B9B2-B906-45AAFC7CC661";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_R_translateX";
	rename -uid "024FD328-48CE-8DDE-5085-5C8DEE4882CE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_R_translateY";
	rename -uid "6C0F28C0-4D95-A8BA-58A3-0288519CDFC1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_R_translateZ";
	rename -uid "A785A164-4ADD-59A8-409B-50A580593005";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_R_rotateX";
	rename -uid "1FCA3841-4BBA-C80E-9A6C-6DB5E09E6E83";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_R_rotateY";
	rename -uid "19CA4849-476C-9E90-B97A-8EA0C4B38B8C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_R_rotateZ";
	rename -uid "51DF853D-4CC6-7261-2DCA-46B6A4451D56";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_R_translateX";
	rename -uid "197078E8-497D-3E26-553E-D7B3C378EEAA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_R_translateY";
	rename -uid "41F08B09-487F-4A21-AC2F-429CF3B293EE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_R_translateZ";
	rename -uid "40214BF7-41A2-B296-B539-A6B7F75DBC7E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine2_M_rotateX";
	rename -uid "B9682BE4-4F7B-CCEB-5AC8-D28C1D4F4392";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine2_M_rotateY";
	rename -uid "8D9FA919-46DA-973E-ADD9-6FA1685C4DAE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine2_M_rotateZ";
	rename -uid "82AA8D36-49CD-4453-6627-53A354B062E9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraSpine2_M_translateX";
	rename -uid "628CEAD2-4F77-E5FD-6058-B4BCA213A5B8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraSpine2_M_translateY";
	rename -uid "2112328B-4FEB-2263-77A5-388F1F6511A2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraSpine2_M_translateZ";
	rename -uid "215DA247-416F-39CE-3736-F9B8406EDE1E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKLeg_R_rotateX";
	rename -uid "56CDFFC5-4788-5F6E-BD81-B29774DDE91D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKLeg_R_rotateY";
	rename -uid "60539908-464E-FAED-AB28-BFA47E8FF3F6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKLeg_R_rotateZ";
	rename -uid "A04FE68C-43D4-8575-2C33-0B8C06EC9E4E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKLeg_R_translateX";
	rename -uid "994BD1AE-4508-3F3E-31F7-608A42E1C417";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKLeg_R_translateY";
	rename -uid "E0532765-4D5A-D884-FAC6-5FBF4286FAF4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKLeg_R_translateZ";
	rename -uid "099972BE-4D40-0282-F984-C8A76E33E371";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKChest_M_rotateX";
	rename -uid "5B7B89B2-4FF0-AFBA-C991-B88328622028";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKChest_M_rotateY";
	rename -uid "5F6BAE4E-48E0-687A-C2D7-55AF9049BDFE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKChest_M_rotateZ";
	rename -uid "7088E250-4534-6632-827F-7496139BCEA8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKChest_M_translateX";
	rename -uid "B5FE636A-45A4-F37A-A619-B68F80DECF79";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKChest_M_translateY";
	rename -uid "55B9ECAE-49C3-69FF-2EBC-85AA868161F6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKChest_M_translateZ";
	rename -uid "C1BA1AD4-4DA6-4DE6-AEFC-8490D689DE51";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_L_rotateX";
	rename -uid "F04F3D86-4FE3-364B-7B36-5194F95FFE00";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_L_rotateY";
	rename -uid "1C43EBA4-4D2F-9F13-6EB7-9EAE7A2C807B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToes_L_rotateZ";
	rename -uid "8FC943A3-4C18-0AD1-9FE0-CC8DB5144C82";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_L_translateX";
	rename -uid "6A94A4EF-4988-7A55-3EA5-019DE9143BCA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_L_translateY";
	rename -uid "532492BF-45FD-848C-B566-0AA3C0A817B8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToes_L_translateZ";
	rename -uid "4E601E8A-4B77-FBDB-FD48-A087066A03E5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_L_rotateX";
	rename -uid "F55525A1-4E43-D4AE-066A-9DA6A7118384";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_L_rotateY";
	rename -uid "40992B43-4153-4A74-776D-0B9587BCE7BD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger3_L_rotateZ";
	rename -uid "C5030329-42E9-853D-F676-3AB6804296E5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_L_translateX";
	rename -uid "06B222E8-4FD5-B3D7-C374-DABD133F0F0F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_L_translateY";
	rename -uid "C6C0E9AD-4D0E-48C5-0F5F-BDA102A22E8C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger3_L_translateZ";
	rename -uid "50F88C6A-4072-ECC8-72D6-8F9A7EBD3322";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_L_rotateX";
	rename -uid "1556824A-4825-B978-1A03-E19D5B8C0537";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_L_rotateY";
	rename -uid "3BA5E345-4A06-A81B-B2CC-9D9FBC43AD74";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_L_rotateZ";
	rename -uid "35052F8D-4F99-F4D4-8EAD-AE994D6512B1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_L_translateX";
	rename -uid "CF86D795-4EC8-20E3-297B-57A4DC9A8154";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_L_translateY";
	rename -uid "C5A8F5E8-45A2-03C9-6022-8A85F058128A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_L_translateZ";
	rename -uid "E8096138-4F23-E956-47F6-248929A51A05";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTU -n "FKIKArm_L_FKIKBlend";
	rename -uid "D0B6F8BF-40BE-72B9-5BB4-1AA46A971DE2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_R_rotateX";
	rename -uid "682F0A14-426E-63B6-907E-419447EE2C94";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_R_rotateY";
	rename -uid "85A431BC-4018-C7F6-312B-95AA9352617C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_R_rotateZ";
	rename -uid "76165433-4D22-6FA4-7FBD-01B424666C34";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger2_R_translateX";
	rename -uid "195538EB-4048-5FF4-F440-DE9B41C0F6B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854719999998e-14 145 -1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraRingFinger2_R_translateY";
	rename -uid "590E8C86-4E6D-4F7F-5A36-E7A9F51F48B4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.776356839e-15 145 -1.776356839e-15;
createNode animCurveTL -n "FKExtraRingFinger2_R_translateZ";
	rename -uid "9D37E9D6-4A1F-5552-DCA5-2FB814A7E289";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleArm_L_translateX";
	rename -uid "9BA833A9-451D-C7B8-768C-46988FAB9659";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0.0063488368160591335 145 0.0063488368160591335;
createNode animCurveTL -n "PoleArm_L_translateY";
	rename -uid "B4F150B0-4FB5-BF31-B403-7A82D69690DF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0.10398121644450953 145 0.10398121644450953;
createNode animCurveTL -n "PoleArm_L_translateZ";
	rename -uid "2E6C3F39-4CC4-DFE1-8161-D9A00877F43F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.9209115338385558 145 -1.9209115338385558;
createNode animCurveTA -n "FKMiddleFinger3_L_rotateX";
	rename -uid "4B25E39E-4D3B-7CA1-EC95-7FB38C9B073A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger3_L_rotateY";
	rename -uid "2AAF7E55-4993-E344-0C59-C8AA051F6E60";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger3_L_rotateZ";
	rename -uid "B1186219-4A00-29EB-4D32-DFB48B50A877";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_L_translateX";
	rename -uid "E8261972-43E2-B48F-29AB-F2A70EEEFAA2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_L_translateY";
	rename -uid "C4C2DC8E-418F-2B5A-21BB-AA9415B5E712";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_L_translateZ";
	rename -uid "0ADBFFEA-4A65-E969-89DB-F28D9A8D476A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_R_rotateX";
	rename -uid "9C7A20B9-4948-4C41-3596-9C8235E9D465";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_R_rotateY";
	rename -uid "20A57C3B-40C0-D585-C2DF-AFAE062019AB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_R_rotateZ";
	rename -uid "6FC6DC15-47A6-5E3B-02CD-958CC74790F9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_R_translateX";
	rename -uid "EBAC9E53-4E55-E24F-B3C4-77A397E85CA7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_R_translateY";
	rename -uid "D67F2B74-4A08-9BA6-4260-4396E69CCF4C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_R_translateZ";
	rename -uid "5CFA4024-4D37-3384-467F-6FBAF5614852";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_R_rotateX";
	rename -uid "E7CDA0F1-49E3-4353-CE12-989615EE0164";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_R_rotateY";
	rename -uid "0251DD30-40B0-6696-59A4-7499F68840D8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_R_rotateZ";
	rename -uid "1027CB1C-468B-BD4B-121A-C9A21CBDC7AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_R_translateX";
	rename -uid "3E3D003C-49C0-F8F1-243F-06BA5C0569A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_R_translateY";
	rename -uid "AFC564F6-4500-63FC-234C-DEBC290FD74F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_R_translateZ";
	rename -uid "231DF35B-4ECD-C575-91D2-A58CFE2BD4A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.842170943e-14 145 -2.842170943e-14;
createNode animCurveTA -n "PoleExtraArm_L_rotateX";
	rename -uid "B5431F8D-4D58-C0A5-047E-26B397EC5DED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraArm_L_rotateY";
	rename -uid "7F4FA0DD-48F9-6DCD-1974-3989819F0FBA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraArm_L_rotateZ";
	rename -uid "D9CB52F9-4F53-FF31-1D85-9BA9D4C02E85";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_L_translateX";
	rename -uid "83143F71-4BFA-D9F4-FDD4-09BA6535CCDF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_L_translateY";
	rename -uid "BB9F7E61-450A-983C-91B7-DDAEE1E1200B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_L_translateZ";
	rename -uid "7800A9C0-48C3-E7BE-1ED6-D7AAF7C214DF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger3_R_rotateX";
	rename -uid "7DD308E2-4831-6276-047A-CEA92419CA64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger3_R_rotateY";
	rename -uid "418B7FC7-43A3-02EA-F67A-45BC1FC4AF6D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger3_R_rotateZ";
	rename -uid "F74F343F-4925-541F-F46D-A6A4B9D4B6AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_R_translateX";
	rename -uid "4EC9ACDC-446B-9F2D-9BEA-759A850E9549";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_R_translateY";
	rename -uid "21E401A3-4C93-D7AD-925D-8B95850DCA51";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger3_R_translateZ";
	rename -uid "D465E083-447C-D615-CE11-8DB33E1170EE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine2_M_rotateX";
	rename -uid "E39AC903-491D-DECF-44D7-DC8BECE03FF3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine2_M_rotateY";
	rename -uid "232EAA2F-4A6C-7A23-B3BF-64A04A451FC2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine2_M_rotateZ";
	rename -uid "5F120B6E-4408-718D-DB89-78900022F97B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine2_M_translateX";
	rename -uid "F60E7D50-4805-949D-8C08-328B023A6976";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine2_M_translateY";
	rename -uid "46A94821-461A-5753-6EAD-2AB930D024A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine2_M_translateZ";
	rename -uid "80CC2014-4960-94C7-EFEF-1E95F4318CA0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleArm_R_translateX";
	rename -uid "799145A0-4B18-CB29-0979-E993DD4E9113";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleArm_R_translateY";
	rename -uid "111DA8EB-435A-BCF3-E4B2-4DAD2205D8E1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleArm_R_translateZ";
	rename -uid "7C70C46A-46C8-4775-0826-3D9CEFE5EC64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "Main_rotateX";
	rename -uid "AC5A8D90-49F5-BAEB-0521-84AB4A8A6599";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "Main_rotateY";
	rename -uid "C12D2C10-41BE-1074-0998-4E887A390F96";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "Main_rotateZ";
	rename -uid "6D4F0F0B-4B15-458D-1772-85AB634BEFF4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "Main_translateX";
	rename -uid "09BE5284-46A7-F515-98A2-3B8853135EFD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "Main_translateY";
	rename -uid "AD3A61D9-4EF8-81BA-06B7-2A8699B0ED48";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "Main_translateZ";
	rename -uid "35F3BB64-42F6-E1C1-41A9-AE8EF09BD93D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_L_rotateX";
	rename -uid "D03367FD-4B33-CF50-4448-1EAC287490AD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_L_rotateY";
	rename -uid "7A7D3A49-49D7-8819-D567-06964A64F034";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger2_L_rotateZ";
	rename -uid "5D0F82BC-4380-A27C-2750-CBA5E877F48E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger2_L_translateX";
	rename -uid "DF4BE731-49CE-00EC-4BC7-6AB7EFC5D5CD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854715202004e-14 145 -1.4210854715202004e-14;
createNode animCurveTL -n "FKExtraRingFinger2_L_translateY";
	rename -uid "78298DD2-429A-3919-41F4-0985A208A144";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.7763568394002505e-15 145 1.7763568394002505e-15;
createNode animCurveTL -n "FKExtraRingFinger2_L_translateZ";
	rename -uid "9CF084FD-45EE-5B77-B30F-1585B3255FEA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_L_rotateX";
	rename -uid "3BBE7873-400B-8757-30E3-B7A38AB604A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_L_rotateY";
	rename -uid "9128C250-41AD-8202-8B74-F29EC96FAD72";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_L_rotateZ";
	rename -uid "006ECD9A-4FDB-9FE9-862A-AC8BE7710760";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_L_translateX";
	rename -uid "B6F1DFC5-46E2-7EBE-DEE4-EE877D54C45E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_L_translateY";
	rename -uid "549FBB71-459E-9840-CD80-E581D19A82D7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_L_translateZ";
	rename -uid "D7D5ABFB-4A06-C9A9-5F39-049A579EE29A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_R_rotateX";
	rename -uid "134CAC8D-42A4-2E9A-F252-98975B6BC48A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_R_rotateY";
	rename -uid "9B197460-4502-3C47-9DB9-8CBEDE187996";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_R_rotateZ";
	rename -uid "7C357924-42DE-FDCC-76D5-5DB1479EAFD8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_R_translateX";
	rename -uid "36A4806D-4B47-860F-BB08-0D837F68796A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_R_translateY";
	rename -uid "C1EA068F-4DA6-EBB8-E151-FA9D5377415F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_R_translateZ";
	rename -uid "78E552DB-43FE-CF02-DAD4-16B9865E75F0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_R_translateX";
	rename -uid "86AE9BD0-4544-F141-D1B0-52A6E8F766DA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_R_translateY";
	rename -uid "6D123A42-4FBC-632E-7D1C-1893A3616ABD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_R_translateZ";
	rename -uid "A866131D-453D-F5B5-F961-8FB355BBC92E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger3_L_rotateX";
	rename -uid "848F2D0D-47BB-0ED3-6941-458E20B1AB29";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger3_L_rotateY";
	rename -uid "ECC121F9-4AC8-964D-C167-DDBEB8FE9713";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger3_L_rotateZ";
	rename -uid "26855EA7-47BB-87F5-E266-708801CD57DB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_L_translateX";
	rename -uid "2E872313-4E5D-DCC0-B738-CBAF5288EC53";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_L_translateY";
	rename -uid "A7368CBE-4C2F-874B-545D-E8AA381592BC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_L_translateZ";
	rename -uid "C6CC2922-4C87-19BB-9EBF-DCBADF302127";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraArm_R_rotateX";
	rename -uid "D1540CB0-4B3F-F750-6356-9EB5017695E1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraArm_R_rotateY";
	rename -uid "81ACC9EC-49D1-5C9B-46D0-678563CA437D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraArm_R_rotateZ";
	rename -uid "9BD182CB-4022-3497-9DEB-4DBE6E710257";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_R_translateX";
	rename -uid "DBDA0B61-43EC-329E-8CEB-1088F8CA39A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_R_translateY";
	rename -uid "73C5E524-4E5A-9BCA-6B06-BE812EDF95BB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_R_translateZ";
	rename -uid "21A297AF-45C0-000B-5EF0-2C921C29DDFA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_R_rotateX";
	rename -uid "4A0FD94E-44D2-4D88-895A-42BCE7C2ECEC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_R_rotateY";
	rename -uid "F4A5DC1C-48DD-240B-AB5B-CE9D2C52CD33";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_R_rotateZ";
	rename -uid "0CCCC122-4941-6A16-A2B4-34AB2E5EA73A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_R_translateX";
	rename -uid "00C8FAAA-4740-EE7B-F7EA-77BD10D97C0B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_R_translateY";
	rename -uid "8E494C2F-42FB-BD5E-D4E9-569EC1C3C87C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_R_translateZ";
	rename -uid "AC0EF50E-4A5A-2C53-4E81-7B94DC1A2D12";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_R_rotateX";
	rename -uid "FD8C2DEC-485C-9FDD-C7F7-1F8745A300F2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_R_rotateY";
	rename -uid "4EEF61B9-4235-1F7D-442E-F6AC479F71BF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_R_rotateZ";
	rename -uid "08430183-4D49-4993-E60E-6B86C8A7D0F8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_R_translateX";
	rename -uid "56AFCCFE-41E6-E311-ADC7-80961DA93C64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_R_translateY";
	rename -uid "FB2A4175-45B4-1322-62E1-B19077AF21AA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_R_translateZ";
	rename -uid "10BC3204-4520-98F8-4755-EE9BD887E3B6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger3_L_rotateX";
	rename -uid "C4FC3A8F-474C-4C38-E988-2B85E65E7A34";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger3_L_rotateY";
	rename -uid "7A6D7D08-4C9A-0EB6-ED3B-2A949263C5A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger3_L_rotateZ";
	rename -uid "E007C861-495C-43A2-EE10-6EB913136901";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger3_L_translateX";
	rename -uid "91ADD40F-4227-41B5-FC6B-93B2A10A40F2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger3_L_translateY";
	rename -uid "A6BBDB0D-42A3-416B-2539-7D94C5BE17E9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger3_L_translateZ";
	rename -uid "587C9D74-46BA-537F-0CD8-C0894AD661D7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTA -n "FKExtraPinkyFinger3_R_rotateX";
	rename -uid "AD70D6CA-4C12-E58C-9DB0-75887ADB925D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger3_R_rotateY";
	rename -uid "7037E369-4055-F8C5-46E9-5DAA715BE24E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger3_R_rotateZ";
	rename -uid "26217E68-4CF4-7EF3-BBCF-D1A7E734EA29";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger3_R_translateX";
	rename -uid "6B5B14FD-43E5-59BA-4DDA-009E57E59EDC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854719999998e-14 145 -1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraPinkyFinger3_R_translateY";
	rename -uid "17A162A7-4B3D-63D3-F517-FAB8AF43DF20";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 3.5527136789999999e-15 145 3.5527136789999999e-15;
createNode animCurveTL -n "FKExtraPinkyFinger3_R_translateZ";
	rename -uid "EC15BB72-459C-BDBE-B94C-158DB1DDB735";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_L_rotateX";
	rename -uid "BE09D563-4F4C-1EA4-B24E-4B8E5FAAC156";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_L_rotateY";
	rename -uid "B13B5C56-4C53-FC9D-B54E-DBBF85BA1042";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger1_L_rotateZ";
	rename -uid "A0458295-4D7C-678F-DEA5-F3B92434A64B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_L_translateX";
	rename -uid "ECC24547-43F5-5FEB-432A-A9A6AF0FF7C6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_L_translateY";
	rename -uid "F9D03359-4F69-E0AA-49DB-07B5D967F915";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger1_L_translateZ";
	rename -uid "AE1CFB6A-4A0C-31D3-4BAB-E1BE66FB5E24";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_L_rotateX";
	rename -uid "92D89C2E-4DBC-2253-F6AB-A4BAF139FAF0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_L_rotateY";
	rename -uid "453CE25C-4470-463B-7B31-15BAC0275F3C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger1_L_rotateZ";
	rename -uid "A4B8BD7F-44E7-DD8B-165A-FE923157A0B0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_L_translateX";
	rename -uid "12DD96B2-40FE-B8D4-716E-86AE50B14217";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_L_translateY";
	rename -uid "772BD07E-4973-7837-3437-508945241BB1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger1_L_translateZ";
	rename -uid "E176C6C0-427A-EAF7-14A6-EAA3E97350C2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTU -n "FKIKLeg_R_FKIKBlend";
	rename -uid "EF34EF5E-4EB9-A492-C067-1EABC8E66FEB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 10 145 10;
createNode animCurveTA -n "FKThumbFinger3_R_rotateX";
	rename -uid "57660939-4048-4663-9006-53A93E7EBA71";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger3_R_rotateY";
	rename -uid "A8A0A052-41B8-6BDA-5312-938AFD1A2253";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger3_R_rotateZ";
	rename -uid "05451A2D-4655-868F-FA2E-9EAE4CAE35BD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_R_translateX";
	rename -uid "7D15F1BA-4453-DABE-4F3C-F3B5555AC19D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_R_translateY";
	rename -uid "DE5DB6C3-44CB-A98E-1822-BB8161E39BB1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger3_R_translateZ";
	rename -uid "E362A167-4498-A37B-FF0E-378D357D699C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_L_rotateX";
	rename -uid "03EA03C8-483D-F028-99C6-8BBCD13016D9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_L_rotateY";
	rename -uid "9C6E8E2B-49FF-F789-6374-D295448E7B5B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger1_L_rotateZ";
	rename -uid "83D019CC-4F25-EF3E-7D2A-67A813C536D0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_L_translateX";
	rename -uid "29D30373-447E-35FE-03DB-6A997738EF9C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_L_translateY";
	rename -uid "6DD01CAA-44DD-56F6-0186-BA9F2CF767A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger1_L_translateZ";
	rename -uid "B0B430C8-44A3-2836-70BF-FE984DB6F001";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_L_translateX";
	rename -uid "94F89785-4070-9DA8-37D3-D2AE052CC909";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_L_translateY";
	rename -uid "C3A9E94E-4EE0-E4B8-1705-4D861A8FC324";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_L_translateZ";
	rename -uid "B0727BC1-41D5-4A3E-D875-CDA7C4C7EAAB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_R_rotateX";
	rename -uid "C1781052-4C3F-07FF-D03E-7BAC572BC113";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_R_rotateY";
	rename -uid "CFEB32F5-4B4E-8119-2A74-F9BB6D11A3D8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKAnkle_R_rotateZ";
	rename -uid "0F860B90-4290-D1CB-5259-4091FEA75573";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_R_translateX";
	rename -uid "6E7DB365-4C1A-F845-B4B6-96A4683D8E63";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_R_translateY";
	rename -uid "238FE11A-450D-6DAA-11F5-799427A2CAA6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKAnkle_R_translateZ";
	rename -uid "6FDD5FD0-41DC-B593-70DD-30A516060832";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraChest_M_rotateX";
	rename -uid "362DF7EB-42A9-839F-5D6C-26BC54273BE3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraChest_M_rotateY";
	rename -uid "C0D2EA3F-493F-626F-3BF3-2EA8547510D1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraChest_M_rotateZ";
	rename -uid "84A5E2D6-4B56-CD68-8862-A1B9AAABC45D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraChest_M_translateX";
	rename -uid "4BB11125-4A96-CAD0-F9F3-6298BDBB193C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraChest_M_translateY";
	rename -uid "67E75DD6-4D28-FBD4-FB10-0894EECE3C8D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraChest_M_translateZ";
	rename -uid "28EB2E2D-4B4D-92D9-BEEF-41B896641FB7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_R_rotateX";
	rename -uid "1F735675-4A55-DB13-B40E-AC8C8DF08A3C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_R_rotateY";
	rename -uid "3AF63496-4BD0-6400-5AAE-74BEF1E9FD69";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_R_rotateZ";
	rename -uid "4B9DDA54-4D10-4301-85C6-B8B2A7F12130";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger1_R_translateX";
	rename -uid "D0F683C2-49A3-CB11-5C29-1585D9F674C4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 7.1054273579999998e-15 145 7.1054273579999998e-15;
createNode animCurveTL -n "FKExtraIndexFinger1_R_translateY";
	rename -uid "C7E8058D-40AE-D302-A76B-1C97AD7438A2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 3.5527136789999999e-15 145 3.5527136789999999e-15;
createNode animCurveTL -n "FKExtraIndexFinger1_R_translateZ";
	rename -uid "369C2297-4BD9-38C0-AA65-D98F9BFAAB70";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "IKSpine1_M_rotateX";
	rename -uid "38273D3D-468B-2573-5E53-5F8B9AE455D4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine1_M_rotateY";
	rename -uid "5255A857-4858-5514-9AAC-759EF5D8E28A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine1_M_rotateZ";
	rename -uid "F9AEF0AB-49F0-79AB-1B69-D98FC613E238";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine1_M_translateX";
	rename -uid "88E367C7-4928-2085-8602-8D872D4621B7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine1_M_translateY";
	rename -uid "0C047935-41A8-3A03-54FF-F695B78785F7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine1_M_translateZ";
	rename -uid "899CD398-490A-6FE0-EE5E-ACB6C033A05A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_L_rotateX";
	rename -uid "75CFE0B7-4912-9C8B-FC2A-7A8BB1AA405C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_L_rotateY";
	rename -uid "F086D052-44C0-934E-7962-E1AD7D736509";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_L_rotateZ";
	rename -uid "4991EBEA-4C59-4696-6E9F-65BC8433F769";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_L_translateX";
	rename -uid "B9564B31-48A5-B77D-E94B-B29E6EFDAA9C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_L_translateY";
	rename -uid "A821CA2D-46E2-F865-B417-00A73ADB020F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_L_translateZ";
	rename -uid "9E4AA56C-4052-8C10-932A-F3B0BC8750A6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRoot_M_rotateX";
	rename -uid "4060EA88-4BF9-634A-B91C-6A86BC0A5970";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRoot_M_rotateY";
	rename -uid "F4C6822D-4A46-1386-C3BE-159946B7D75D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRoot_M_rotateZ";
	rename -uid "DAAF4822-437E-6C34-FC7F-A18A45DA8E80";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRoot_M_translateX";
	rename -uid "EAC398E5-41A0-DEEC-C7B9-B98CB398A022";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRoot_M_translateY";
	rename -uid "8F2DE5C1-42BB-5326-581D-2DB05C6B4103";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRoot_M_translateZ";
	rename -uid "00036BB7-44D8-B0D7-EC4F-F89B6CA3CEA4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_L_rotateX";
	rename -uid "C16F920B-40C4-FC68-92EF-7F800928AF60";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_L_rotateY";
	rename -uid "09D17DCF-4C07-6BC0-BA34-13924ACAF851";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_L_rotateZ";
	rename -uid "B1D32144-4629-A069-9123-57A5373ED25C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger3_L_translateX";
	rename -uid "FACAA12E-491F-332C-1139-699EFDED3390";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -8.8817841970012523e-16 145 -8.8817841970012523e-16;
createNode animCurveTL -n "FKExtraThumbFinger3_L_translateY";
	rename -uid "B8293C48-440A-6ED2-9033-958A9313137D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger3_L_translateZ";
	rename -uid "6DDD4EF1-4C8E-3B35-7026-A7B5E1827B6E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_L_rotateX";
	rename -uid "25091757-4583-3E74-877B-B8AE47246698";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_L_rotateY";
	rename -uid "144306D3-49B2-23AF-A16A-18A916DCF493";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_L_rotateZ";
	rename -uid "4BFEA4D8-4D7C-2F4C-EEFF-B08F66DCBE16";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger2_L_translateX";
	rename -uid "5953BD02-4E84-F151-664C-1FA1F491E2B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger2_L_translateY";
	rename -uid "19E955CE-4AD1-AA5B-9200-5DB829960E71";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger2_L_translateZ";
	rename -uid "A06D322D-43C1-B65E-DE59-A1AB2DC39E4F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.8421709430404007e-14 145 2.8421709430404007e-14;
createNode animCurveTA -n "FKExtraThumbFinger2_L_rotateX";
	rename -uid "585F4E9A-4E8D-FFE2-11BE-049FC12A497A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger2_L_rotateY";
	rename -uid "5AFA66EA-4490-3391-B6C6-18925B73CD4F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger2_L_rotateZ";
	rename -uid "D341BC2D-4996-4640-4A5F-D5B9A16190EF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger2_L_translateX";
	rename -uid "E8645966-4598-E988-FCD0-309275362513";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.7763568394002505e-15 145 1.7763568394002505e-15;
createNode animCurveTL -n "FKExtraThumbFinger2_L_translateY";
	rename -uid "7568D665-490E-095F-1807-BEB0CE3D21DA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTL -n "FKExtraThumbFinger2_L_translateZ";
	rename -uid "CE1189C4-4FD4-BBA6-D75E-A78027666015";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 7.1054273576010019e-15 145 7.1054273576010019e-15;
createNode animCurveTA -n "IKExtraSpine3_M_rotateX";
	rename -uid "4E4E25A2-490E-5866-76AF-7D90DE178B1F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine3_M_rotateY";
	rename -uid "9D58961F-48E1-2EC1-E89A-B8B94909BF9E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine3_M_rotateZ";
	rename -uid "E852F099-46E2-8F63-CA41-6EA70377385B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine3_M_translateX";
	rename -uid "EC063CB2-4876-9F9E-235C-439F7D39F491";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine3_M_translateY";
	rename -uid "23AFAC4F-414C-F065-FEFC-8EA4C3872DA4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine3_M_translateZ";
	rename -uid "8BA7F4C3-479B-A1C8-BD49-C087F14B5BA7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootExtraX_M_rotateX";
	rename -uid "D22EDC55-469B-348E-C245-97B5571AD437";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootExtraX_M_rotateY";
	rename -uid "AA2CC1B1-4DFD-1B90-73E6-E889E61A790C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RootExtraX_M_rotateZ";
	rename -uid "90DC2C6B-44CB-BFD2-D4F7-8293F6CB2F93";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootExtraX_M_translateX";
	rename -uid "64018A8C-421B-C082-8301-1C94E2F288F5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootExtraX_M_translateY";
	rename -uid "B3013A3C-46DF-D672-C388-2F99A4BC418B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RootExtraX_M_translateZ";
	rename -uid "03D0D94A-489D-3522-5087-92965F486123";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine1_M_rotateX";
	rename -uid "76F7A3FB-4556-816C-3701-3DA08829C9F3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine1_M_rotateY";
	rename -uid "A2170B14-4B06-D3B6-731C-EABF23841ADE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine1_M_rotateZ";
	rename -uid "50BABF65-4134-C948-5AC2-AEB5234103ED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine1_M_translateX";
	rename -uid "8AE51697-4579-44A7-AD20-40BEAE5ED42A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine1_M_translateY";
	rename -uid "317EC2BB-419B-8E60-C98C-D38F741D3113";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine1_M_translateZ";
	rename -uid "41B232D6-4AAA-2C8B-85F9-E8ACC18C420C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -3.1554436210000005e-30 145 -3.1554436210000005e-30;
createNode animCurveTA -n "FKExtraMiddleFinger3_R_rotateX";
	rename -uid "E4EA21CC-41DD-DD2E-094E-A8AB2C80BADD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger3_R_rotateY";
	rename -uid "755B04AE-41FD-343D-065F-E99831A4D985";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger3_R_rotateZ";
	rename -uid "CF17030C-4FA3-BF05-4C83-3C9A87B79D19";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger3_R_translateX";
	rename -uid "9C75CD73-47C2-04FF-2A03-A0886CD77B0E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854719999998e-14 145 -1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraMiddleFinger3_R_translateY";
	rename -uid "BF78F8AB-4235-6852-76C7-D8B9A806D966";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger3_R_translateZ";
	rename -uid "33098E08-40BB-133F-05CA-76BD52DF8A1E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "FKPinkyFinger2_R_rotateX";
	rename -uid "FB473A4C-4205-91C6-6744-ADA2F9A66DC2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger2_R_rotateY";
	rename -uid "28C04462-4969-7DD9-C229-D7A2EF865FAB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger2_R_rotateZ";
	rename -uid "F87546D5-4521-1660-DA27-FEA230237FDF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_R_translateX";
	rename -uid "B0624AD8-4D0E-A200-C02B-C98E8BAAF695";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_R_translateY";
	rename -uid "DF652170-4104-781A-9D6A-F9B3AAC563A1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_R_translateZ";
	rename -uid "E3EFC18E-463D-D5F7-02B7-D1A5F5F62A3C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_R_rotateX";
	rename -uid "19D81F0A-4BF7-CC01-9004-709D8C06CBE9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_R_rotateY";
	rename -uid "344DAE4C-4062-AD36-F594-46B89744D70F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_R_rotateZ";
	rename -uid "9E9F315E-4747-DC3D-9E3B-6CA76445C5DA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_R_translateX";
	rename -uid "9D72FEE4-491D-CCB2-2B01-758B59CEC762";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_R_translateY";
	rename -uid "BDC1B378-4AC1-C0DA-50E5-F783994A6DCF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_R_translateZ";
	rename -uid "3E53D984-49FB-ED0C-E4EA-1E83EDE675BF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKShoulder_R_rotateX";
	rename -uid "23DE8EFB-4249-F04F-6D23-349D2833EA09";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKShoulder_R_rotateY";
	rename -uid "DE397C76-4F9F-76A3-6A49-77977ACF67A7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKShoulder_R_rotateZ";
	rename -uid "E0FA3F57-416D-6F4B-0595-3C851F3C278E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKShoulder_R_translateX";
	rename -uid "8DCCBB04-40F6-925B-EC87-D6B20BE94DEA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKShoulder_R_translateY";
	rename -uid "4CE84499-4439-55FD-359F-E386C7A5D2AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKShoulder_R_translateZ";
	rename -uid "0296B035-4F46-4401-3FB4-1E9963D74367";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_R_rotateX";
	rename -uid "CFC084B2-4DD1-7223-2DD6-B086761C7B73";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_R_rotateY";
	rename -uid "932640C0-4CE9-58A9-DCEB-06A85CB6F268";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_R_rotateZ";
	rename -uid "EB22B9BC-4335-169F-2A87-17BC0990A8AD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_R_translateX";
	rename -uid "64FA6DA6-4EE7-2AB1-F2E0-D48080022E6D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_R_translateY";
	rename -uid "FF2C4610-4804-F2E2-CCC9-65984728984A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_R_translateZ";
	rename -uid "1851C5FF-45C2-DBFB-5962-6C94CA8485C0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKShoulder_L_rotateX";
	rename -uid "FE775738-4E0D-B2F2-2709-229CB7E5948C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -3.5781249797651298e-15 145 -3.5781249797651298e-15;
createNode animCurveTA -n "FKShoulder_L_rotateY";
	rename -uid "8E840D82-4B4B-432C-0592-8699BBCEEC39";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.0187713875796706e-14 145 1.0187713875796706e-14;
createNode animCurveTA -n "FKShoulder_L_rotateZ";
	rename -uid "4DB6D4FA-4B8D-0DEB-AB32-F38161FC415D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.083317314883511e-05 145 1.083317314883511e-05;
createNode animCurveTL -n "FKShoulder_L_translateX";
	rename -uid "CB633CF9-4E78-F1D0-6099-31BE4558B71C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKShoulder_L_translateY";
	rename -uid "CB565A14-4BE5-0E9F-F9FF-59ACD42F1263";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKShoulder_L_translateZ";
	rename -uid "574897D9-46E3-EEED-D6BB-A7AEFB672C4C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_L_rotateX";
	rename -uid "A3B27D89-43AF-CC13-1B41-FA9B17B01849";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_L_rotateY";
	rename -uid "079917CB-48EE-1FCE-6D88-2293185388DC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraHeel_L_rotateZ";
	rename -uid "6A0AFEC4-45A8-4A94-F242-99AFAB959D4F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_L_translateX";
	rename -uid "BCB274C4-4873-0E2F-C745-AD87774D069D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_L_translateY";
	rename -uid "08608F8C-4C06-9006-E99E-CDA7FDA652F9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraHeel_L_translateZ";
	rename -uid "A1964B28-4369-401D-552F-6AA8BD726E32";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine2_M_rotateX";
	rename -uid "E4F06A05-4479-09AD-A8E4-51A577B5FBA4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine2_M_rotateY";
	rename -uid "F4403FA1-416F-1202-0903-A9ACB1734110";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine2_M_rotateZ";
	rename -uid "59E9C281-4B78-03F7-424E-15BCE3FA6900";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine2_M_translateX";
	rename -uid "A11600EE-4B6B-A9CE-6729-A09078335EC7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine2_M_translateY";
	rename -uid "8122CCEE-488E-DE85-A8F9-45918D1A3972";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine2_M_translateZ";
	rename -uid "81DBADC2-4679-2E9D-4F1C-15870677AE51";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_L_rotateX";
	rename -uid "4C8E39E1-4700-D2B4-0669-3F95099F657E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_L_rotateY";
	rename -uid "8B60F61E-4FA6-EF79-48CA-D0940AB02732";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger3_L_rotateZ";
	rename -uid "DF65AF2C-4EF3-1201-4178-DDA567296847";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_L_translateX";
	rename -uid "9211029F-4B9E-8C26-46B0-7BB38D30420E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_L_translateY";
	rename -uid "89B55A68-4B78-D94F-03B2-36AA4A5EEFE0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger3_L_translateZ";
	rename -uid "4817FEDD-4CCE-3B3F-2220-D2B844DB52A8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHead_M_rotateX";
	rename -uid "1F2A6645-4EED-91A0-FE1E-D28B25881035";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHead_M_rotateY";
	rename -uid "55EE438B-441A-4586-DA81-42917B726C52";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHead_M_rotateZ";
	rename -uid "08124A6A-4E20-6A0B-CCF5-6DAA026B6D1A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHead_M_translateX";
	rename -uid "1F4A89E2-4ABD-652C-603A-6DA72587A823";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHead_M_translateY";
	rename -uid "16ABBDF4-4959-D7E2-2A10-B0AD62F37931";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHead_M_translateZ";
	rename -uid "DD380CAA-428A-09FA-9427-BE932A69D01D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger2_L_rotateX";
	rename -uid "EEDAD0E7-4D75-11FA-3C54-CF96971334C7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger2_L_rotateY";
	rename -uid "A8D2B253-4271-7BA0-B91F-F6A54F72B5D8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger2_L_rotateZ";
	rename -uid "2D55EF10-4F17-B142-485B-D78152DD382D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_L_translateX";
	rename -uid "5CEA7710-40AA-4569-A9C8-92A3DB41E4BF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_L_translateY";
	rename -uid "C3857D7D-4DFB-9417-2F9F-2A912D45A399";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger2_L_translateZ";
	rename -uid "4F95C465-4373-E9EF-5681-449FFB0CE14B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine2_M_rotateX";
	rename -uid "D4295FF3-46AC-4D71-10A6-C799326C2946";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine2_M_rotateY";
	rename -uid "AFB0D6CA-481C-1E27-FE0D-2F9DCC398CC5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine2_M_rotateZ";
	rename -uid "4AB8B3B6-4292-D0C5-9DEB-FFA2936A1E24";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine2_M_translateX";
	rename -uid "5D5208C8-416E-302F-2656-A29B0725889D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine2_M_translateY";
	rename -uid "28ADAB6E-4AB6-4445-7DBC-3E8BC1DDF6BF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine2_M_translateZ";
	rename -uid "CBCA5E6E-47A9-5F59-3E43-47BB9B0ACEF0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_L_rotateX";
	rename -uid "2C9D8134-46C2-3AAE-3D08-57936D818DBC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_L_rotateY";
	rename -uid "8FF3F79D-45A5-61FA-8F5D-63B1E30CF160";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_L_rotateZ";
	rename -uid "D18AD939-4B5E-B6D5-2EBC-7E9E76A952B7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_L_translateX";
	rename -uid "42692104-44CA-5C93-AF6C-968D70C9D516";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_L_translateY";
	rename -uid "DFA6C45D-4C6B-935A-194E-99B71EA51A87";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_L_translateZ";
	rename -uid "AAF42978-407D-9E83-3BFD-E9A3B18B79C0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_L_rotateX";
	rename -uid "CD0753A5-43B8-CA21-3390-F1B6E3071D42";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_L_rotateY";
	rename -uid "EC2E3100-40AF-55E1-BC5F-79AE24BFD28A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_L_rotateZ";
	rename -uid "4301A3F6-40B9-599F-2FE6-D1AB7B2C26AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_L_translateX";
	rename -uid "1AFC1D0B-4DD2-D690-07E9-79B80E4968C8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_L_translateY";
	rename -uid "AC01FC5C-446A-3291-574A-519F1EFB45C3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_L_translateZ";
	rename -uid "812E7469-43C0-DF26-8C55-69BACC2354C7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger1_R_rotateX";
	rename -uid "536C4CC5-456C-8446-73B0-5293311E2A45";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger1_R_rotateY";
	rename -uid "5B0A06D1-40DF-5148-9F42-CCA7F29984AA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger1_R_rotateZ";
	rename -uid "69A91026-4B0D-A266-C3BA-1F8BF8CB05EA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_R_translateX";
	rename -uid "B5DB63D8-4E77-417C-0494-D9B25C670F4C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_R_translateY";
	rename -uid "E566DB00-4501-9143-E0D1-D4B0BBD09B6C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_R_translateZ";
	rename -uid "479320A2-4775-8FA4-2484-0C82DC1EF9C3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_R_rotateX";
	rename -uid "0CAB6467-4716-6BEB-2476-1DAD4CCAFB7A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_R_rotateY";
	rename -uid "5746364C-4D3F-49C6-CC4B-1691DEBE5EED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_R_rotateZ";
	rename -uid "7B4BE4A9-43A7-5BD4-A69D-DE91D3ADF99D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger3_R_translateX";
	rename -uid "0752C640-43CB-B6C1-9D24-EA98699B454C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger3_R_translateY";
	rename -uid "3F2E08B5-4BF1-FB55-FF9A-168A13C0880D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -5.5511151230000001e-17 145 -5.5511151230000001e-17;
createNode animCurveTL -n "FKExtraRingFinger3_R_translateZ";
	rename -uid "DF6C8FB4-4537-661E-BE8B-8D9223B2D38C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.842170943e-14 145 -2.842170943e-14;
createNode animCurveTA -n "IKExtraArm_L_rotateX";
	rename -uid "C6150047-4DE5-0604-6D75-4EA98E88DE78";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraArm_L_rotateY";
	rename -uid "F3A970F5-4D6C-04C8-38C1-128E27CAF278";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraArm_L_rotateZ";
	rename -uid "784C3E28-445B-60FE-DDE8-5F81435A114B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_L_translateX";
	rename -uid "46B39CDF-4C7A-2344-DC90-95B9B6E45045";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_L_translateY";
	rename -uid "4BC380B5-47AD-D694-F3CF-82B2DF791156";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraArm_L_translateZ";
	rename -uid "E4409429-45D4-46FA-3359-108C8B1A8AC4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_R_rotateX";
	rename -uid "0A6EB214-4F26-4B75-EBA3-6CAE6069775C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_R_rotateY";
	rename -uid "A09E1084-44C9-4DD8-9856-E184D7D74817";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKToes_R_rotateZ";
	rename -uid "1B719DAA-4582-9906-86C3-C7BBE1390FFF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_R_translateX";
	rename -uid "7B4219EA-44D0-4882-44E7-F9A70A29E705";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_R_translateY";
	rename -uid "7BB1A178-48AD-B043-A3A8-47B384422F59";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKToes_R_translateZ";
	rename -uid "492E54F4-4BC3-9BBC-C9DC-C1808EE076F2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_R_rotateX";
	rename -uid "C124FA18-46C4-4DB8-D2B0-0AA67E4EC8C8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_R_rotateY";
	rename -uid "492590D0-44DB-319B-9CDB-6A8B57121329";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_R_rotateZ";
	rename -uid "7AD172AF-40B4-CFD0-0D96-39830D99E59C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_R_translateX";
	rename -uid "E18EC8BD-42C2-E7EC-364D-6EBD4A343EC7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_R_translateY";
	rename -uid "E415906A-4220-12E4-9051-3A90297900D5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_R_translateZ";
	rename -uid "670A7CDA-4A03-B6B0-27C5-47A1F5DCA658";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_L_rotateX";
	rename -uid "4FF2549D-4392-CB2D-B43E-22B1B0F9B85A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_L_rotateY";
	rename -uid "F63BDB2C-41DB-F827-2B3B-FA81FFCA2496";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraLeg_L_rotateZ";
	rename -uid "BEA76292-4D72-989B-D959-EA896AF264EB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_L_translateX";
	rename -uid "461B05C5-4030-2F08-6738-48AC51FCAEC9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_L_translateY";
	rename -uid "71D8CD48-4217-96EF-3DD9-3EB4EC5888F1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraLeg_L_translateZ";
	rename -uid "959FCF91-4658-0F05-E677-7CAA8848AC6E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_L_rotateX";
	rename -uid "18CE367A-4B1E-7B06-14D6-FAA14F4358B2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_L_rotateY";
	rename -uid "56EAD131-4D70-61AF-CA62-3D806EF261C9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_L_rotateZ";
	rename -uid "BB096FBE-448A-7C8D-B83A-E6A77C1FFACB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_L_translateX";
	rename -uid "4DEF7F5F-4F55-9E0D-23AA-43882304B542";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_L_translateY";
	rename -uid "F8C6E864-4075-543C-2EAC-F6AF591AC872";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_L_translateZ";
	rename -uid "E3C6DD24-4B1E-DDEB-7B63-A79EE1466EBF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_L_rotateX";
	rename -uid "3A42591A-4E26-2258-0B5B-779EA5EFA416";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_L_rotateY";
	rename -uid "A56E4B6A-4F12-DFFF-0C7B-9581F00ECC17";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger3_L_rotateZ";
	rename -uid "28E40CFE-4C46-FACA-D096-528F493341C4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger3_L_translateX";
	rename -uid "6C0B65FB-4CB9-D7AE-C822-4F9C998C5FA1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.4210854715202004e-14 145 1.4210854715202004e-14;
createNode animCurveTL -n "FKExtraRingFinger3_L_translateY";
	rename -uid "46471C7D-4A8F-6A7C-4653-A88371705259";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 7.4940054162198066e-16 145 7.4940054162198066e-16;
createNode animCurveTL -n "FKExtraRingFinger3_L_translateZ";
	rename -uid "D7A457A3-4536-9590-C088-6A9815E35209";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.8421709430404007e-14 145 2.8421709430404007e-14;
createNode animCurveTA -n "FKPinkyFinger1_L_rotateX";
	rename -uid "06919C60-4D82-CD39-F055-4A805C39FF00";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger1_L_rotateY";
	rename -uid "D4963F59-45F1-000D-4B13-CBAB31C8A9C3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKPinkyFinger1_L_rotateZ";
	rename -uid "12707436-42E0-AB70-A7F5-28AC05893C90";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_L_translateX";
	rename -uid "D7183256-43AF-0FAA-5D80-1D9752E38B20";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_L_translateY";
	rename -uid "AF4AC982-4469-03D4-65E1-DB8EDE272D0E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKPinkyFinger1_L_translateZ";
	rename -uid "D3777F5C-43B4-1184-7DAA-0985B700B2C0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToes_L_rotateX";
	rename -uid "38934AD0-4D35-4693-2BAA-3F9029382BE6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToes_L_rotateY";
	rename -uid "0F3DD643-432F-B199-50D1-0786D171CB4C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToes_L_rotateZ";
	rename -uid "80F75833-4A18-A362-DBDE-9D886B312176";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_L_translateX";
	rename -uid "2E8E7093-4A08-A884-3432-FA9268FFAC49";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_L_translateY";
	rename -uid "81685250-4286-CFB5-2AF6-05832251AA8E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_L_translateZ";
	rename -uid "1C2C4F1F-4093-8978-A928-7BA2B4D097AF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_R_rotateX";
	rename -uid "9DB8E24F-4082-B5FA-56A7-B2804A20D1A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_R_rotateY";
	rename -uid "6153C33C-4DC2-8662-B7E0-E9A82E143BE3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollHeel_R_rotateZ";
	rename -uid "7B862537-4FF6-FBD3-60EC-159571977094";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_R_translateX";
	rename -uid "B951E231-4DDD-9978-4D44-81832F81276D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_R_translateY";
	rename -uid "F88413AF-4EA5-D81A-0AEB-DAAACE7B46FF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollHeel_R_translateZ";
	rename -uid "6B9337DD-432F-27E8-73E6-E787E9173268";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_R_rotateX";
	rename -uid "8EC89F92-40CE-9183-0BE3-49BD44DF7089";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_R_rotateY";
	rename -uid "CFB9E94B-49AF-5C6A-D1D8-61A243A99B35";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollExtraToesEnd_R_rotateZ";
	rename -uid "A71EDDDE-45B4-9F62-C028-F5B75B158903";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_R_translateX";
	rename -uid "8769EF34-4D3C-FD40-AFF9-8DBF2A69ADE6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_R_translateY";
	rename -uid "299087F4-4174-D559-2ED9-7FA87F97B58C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollExtraToesEnd_R_translateZ";
	rename -uid "B9B25860-4225-DB43-7E5B-F8AAD0E07A02";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_R_rotateX";
	rename -uid "3A028D14-4359-809D-6FDC-05B07D8FB1DD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_R_rotateY";
	rename -uid "22DD5957-4148-083B-83C4-EFA9F6797B2B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_R_rotateZ";
	rename -uid "549CD92E-440D-46E7-5D95-E6A5C4A600DA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger1_R_translateX";
	rename -uid "41906053-4F5F-3A1C-67AB-46BC3D30AF7E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger1_R_translateY";
	rename -uid "D424DFDA-4E69-EA67-F135-20BD81A5383D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger1_R_translateZ";
	rename -uid "3E4DFB0B-4498-F17E-2D79-FB9C229EC334";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "RollToes_R_rotateX";
	rename -uid "E9B911B6-40F2-4090-2C57-BC82CD837EA7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToes_R_rotateY";
	rename -uid "CFBE4B23-4361-3AB6-CBE0-30A0A6106574";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToes_R_rotateZ";
	rename -uid "CE146728-4157-4A39-A2B9-0EBD56914820";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_R_translateX";
	rename -uid "6F80B4CA-41B6-56BB-966B-BDBC0ADDC889";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_R_translateY";
	rename -uid "B293C127-4B7B-8B72-5240-78A73472D095";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToes_R_translateZ";
	rename -uid "17FE5CD7-49E6-0E7E-59F7-42A20D038435";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKJaw_M_rotateX";
	rename -uid "8E1A09B5-4F07-2632-33E0-3A8D5C417D6D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKJaw_M_rotateY";
	rename -uid "C978E361-4C21-AE3A-F2C0-A499D8FD8241";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKJaw_M_rotateZ";
	rename -uid "3324C59F-4BDA-CEF8-E1CD-C5908FD42956";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKJaw_M_translateX";
	rename -uid "D8BEA8E7-468C-D678-08E4-9F944890B569";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKJaw_M_translateY";
	rename -uid "A2B09122-402B-5C14-70DB-928312917D5A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKJaw_M_translateZ";
	rename -uid "F5ABD363-40F1-F58F-7664-45B9F292E40E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_L_rotateX";
	rename -uid "E207246B-4618-8904-7CE5-E7B4FCC52465";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_L_rotateY";
	rename -uid "D2CFED02-4185-61EA-195B-DFB3895FA134";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_L_rotateZ";
	rename -uid "A3CDFF5F-448D-550D-29A7-A68DDFDD9C9F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_L_translateX";
	rename -uid "AD7BA8D2-40B2-92AA-C869-13ACAEF13138";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_L_translateY";
	rename -uid "13D7628C-461B-223F-796A-04913860055F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_L_translateZ";
	rename -uid "6F760166-4FE2-93FE-5884-9B87728A1AAC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine1_M_rotateX";
	rename -uid "EB64CD34-43C3-3390-60E3-A49B8F0E5B38";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine1_M_rotateY";
	rename -uid "A0396AA9-4667-5669-1EB8-439565C4710E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine1_M_rotateZ";
	rename -uid "6D29E534-45F5-A7BF-8EB6-6C924C9B2248";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine1_M_translateX";
	rename -uid "9AFCD40F-4FB0-E19C-BEBA-9FBB65A37D97";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine1_M_translateY";
	rename -uid "D46EF73F-4261-F10C-0C93-7EA7CEE7A67E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine1_M_translateZ";
	rename -uid "703BA5DB-47D4-D158-F509-6B99D4B5DBC3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraArm_R_rotateX";
	rename -uid "8DFFB0E4-4FC9-387B-8753-81BF834B2364";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraArm_R_rotateY";
	rename -uid "446A2A30-49F7-E919-9218-4CB1CFFF5614";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "PoleExtraArm_R_rotateZ";
	rename -uid "C558479A-4E89-B926-C8B3-319C7D574066";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_R_translateX";
	rename -uid "088A4E99-47DD-C1FB-4B40-2C8C1B9CFEE0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_R_translateY";
	rename -uid "5368C6C0-4DA2-7911-BC3A-6BA92673DDB8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleExtraArm_R_translateZ";
	rename -uid "714862E0-4D51-E51B-E2C3-62958A2F5AD8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine3_M_rotateX";
	rename -uid "DAE88C31-4DBD-BA7D-8254-639F8DF02A26";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine3_M_rotateY";
	rename -uid "0668EC5D-45E9-D76C-1638-59B7258ABB04";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKSpine3_M_rotateZ";
	rename -uid "EE7F5CEB-4AC3-6370-75C4-35BF7A6CD116";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine3_M_translateX";
	rename -uid "A8CED57F-49F4-918A-29F7-7EA6C606C585";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine3_M_translateY";
	rename -uid "58403A02-466D-C4A6-E06B-93AE2658B86A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKSpine3_M_translateZ";
	rename -uid "11CA72D7-4054-2C63-9C36-37A33B79E1B6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_R_rotateX";
	rename -uid "DA212117-4528-BC64-EAA0-2EB731BBD56F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_R_rotateY";
	rename -uid "2D47FDD9-4C26-CBA7-F447-3E962D8C92AC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraToes_R_rotateZ";
	rename -uid "5756B318-42B7-2E37-DD09-9F9FAAA0E72F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_R_translateX";
	rename -uid "AD4A798B-4DBD-8CE4-1F55-5EBDA49D10A1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_R_translateY";
	rename -uid "183A3CB2-41A6-DE3C-9C44-959C3F0FF8F5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraToes_R_translateZ";
	rename -uid "99DDFF96-48AB-8CDB-6203-A08CDCA8B9B7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_R_rotateX";
	rename -uid "B3622159-493F-BFD9-F5A3-A5ADFD9C7297";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_R_rotateY";
	rename -uid "640AFD5D-4F43-F783-04E4-45B9BFF37716";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_R_rotateZ";
	rename -uid "AA8CED0A-437B-774F-069F-40AEBB8E3D4E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_R_translateX";
	rename -uid "47BF66EC-4DDD-08DA-24A7-7889922AD370";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_R_translateY";
	rename -uid "A6829837-42C6-630F-C472-0EAB7B7DCF79";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_R_translateZ";
	rename -uid "5F3597FB-48DE-F328-5DD0-1486D2056EDF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_L_rotateX";
	rename -uid "14526A05-441C-4837-E22A-9B89C29BFCDA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_L_rotateY";
	rename -uid "07C098DA-41E2-5925-30F4-BFBA006EE12B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_L_rotateZ";
	rename -uid "17994574-40CB-C17A-83E3-C297F0764DAE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_L_translateX";
	rename -uid "7578E1B3-4626-97E8-5A0E-999AA64CC8F9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_L_translateY";
	rename -uid "869699E3-48FD-27F1-1882-7288BB61B83E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_L_translateZ";
	rename -uid "A2A39DB2-45B2-1E0C-371D-FD9BFCF65006";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_L_rotateX";
	rename -uid "645F7347-4F22-9974-26DD-749F3DDBAC80";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_L_rotateY";
	rename -uid "716EB333-4C4F-981B-0FBF-B8B6B8E4A96D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger1_L_rotateZ";
	rename -uid "0B6E2818-46B6-811D-DB8B-6CA0445F36E5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger1_L_translateX";
	rename -uid "395F91F9-4A65-7E18-FA27-FAB4649F0FB2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger1_L_translateY";
	rename -uid "B12A7670-48C1-6182-AE50-738F4728C4A0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 8.8817841970012523e-16 145 8.8817841970012523e-16;
createNode animCurveTL -n "FKExtraMiddleFinger1_L_translateZ";
	rename -uid "5FFFDBB0-45C9-ECE4-6BEA-FFA4E02B1381";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTA -n "FKEye_L_rotateX";
	rename -uid "8755CEC0-4A6D-B901-207D-D083EAE388A0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKEye_L_rotateY";
	rename -uid "356BC88D-4136-262C-6BF9-02AAC1A65E88";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKEye_L_rotateZ";
	rename -uid "4BA1070B-4CA2-1968-9D28-1590343090D6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_L_translateX";
	rename -uid "FE7CFB86-43D6-61C3-C1A1-5F8D5831BC2A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_L_translateY";
	rename -uid "93B907A3-49FC-9A6C-A26C-79A3A80B859E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_L_translateZ";
	rename -uid "0B27390B-4E30-3801-DC80-279802934764";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_R_rotateX";
	rename -uid "645EB138-4693-4A87-8D50-AC9FB5E3592C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_R_rotateY";
	rename -uid "5A836287-4185-90B6-E6DB-F9B32B6006E7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger2_R_rotateZ";
	rename -uid "48812BB4-4290-D83C-62F5-81B018EAED30";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger2_R_translateX";
	rename -uid "D3A3FAB0-43ED-22F0-28F8-25912844DE58";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854719999998e-14 145 -1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraMiddleFinger2_R_translateY";
	rename -uid "D4B21C06-405F-E15B-9B41-B7A6B3E384AD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -8.881784197e-16 145 -8.881784197e-16;
createNode animCurveTL -n "FKExtraMiddleFinger2_R_translateZ";
	rename -uid "B86CC584-4D25-1403-CE0C-9A98F353E6AB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "FKExtraMiddleFinger3_L_rotateX";
	rename -uid "3168E81A-49D5-2B44-7D23-3895450D8ADB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger3_L_rotateY";
	rename -uid "3F1AD2F2-4AC4-5349-BE48-6489C404A9BE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraMiddleFinger3_L_rotateZ";
	rename -uid "B898DBD2-4ADE-B1A0-F2EE-4EBEDD747554";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraMiddleFinger3_L_translateX";
	rename -uid "6889DB29-4103-F1FA-C14B-A5979C2FD51E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.4210854715202004e-14 145 1.4210854715202004e-14;
createNode animCurveTL -n "FKExtraMiddleFinger3_L_translateY";
	rename -uid "6EA65105-4196-8268-A3CB-868CE18D0307";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 8.8817841970012523e-16 145 8.8817841970012523e-16;
createNode animCurveTL -n "FKExtraMiddleFinger3_L_translateZ";
	rename -uid "AC719D8B-42D1-89DF-2CB9-EE97F9521A2C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -5.6843418860808015e-14 145 -5.6843418860808015e-14;
createNode animCurveTA -n "FKRingFinger2_R_rotateX";
	rename -uid "E33F3F25-4574-7E47-9AAF-8B832F8AB094";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger2_R_rotateY";
	rename -uid "FE5FAA7F-434D-D945-4ED1-6D8155D32ADD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger2_R_rotateZ";
	rename -uid "0550CDB3-4BC2-0832-7963-D68DA2DECB3F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_R_translateX";
	rename -uid "A2E0714A-4718-9BE0-17E8-14A6A60654FB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_R_translateY";
	rename -uid "8C43FE64-4C0C-14BB-1EC0-138646CE91E0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_R_translateZ";
	rename -uid "B0E18F49-442B-2A85-6C2E-F2A83AC69D38";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_L_rotateX";
	rename -uid "34427E02-4BF1-B0ED-DD49-C5BF989C7DAE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_L_rotateY";
	rename -uid "7DB4C1F5-43C1-B7A5-A6B8-7496F05BA06B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_L_rotateZ";
	rename -uid "2D25D89F-4300-59C9-AA90-8D9D29D0B6F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_L_translateX";
	rename -uid "9C76BEAA-46E9-C6BE-0E14-5DA3D2BA2A7C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_L_translateY";
	rename -uid "A97FF077-4668-0D8A-CED5-12A144CD4A27";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_L_translateZ";
	rename -uid "0DE9599B-4155-5E6B-2EAB-F3A53E299BB3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_R_rotateX";
	rename -uid "6F830F71-4858-3405-9D16-F3A568ED70D3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_R_rotateY";
	rename -uid "51B4AD72-425D-1B35-2CBB-0885CFB8CFD5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraKnee_R_rotateZ";
	rename -uid "B1CD7450-480D-B33E-4EC0-7DB3168DE83A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_R_translateX";
	rename -uid "B8AD2A19-4482-56CA-55B7-C19E706DFB1D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_R_translateY";
	rename -uid "D01EE672-4929-7BF6-6F91-E4ACDE963198";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraKnee_R_translateZ";
	rename -uid "433E3774-4608-E246-3822-97904D82C627";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger2_L_rotateX";
	rename -uid "5D2213D0-40D4-C21D-C7C9-A58FBD148E61";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger2_L_rotateY";
	rename -uid "306303EA-44F0-4BC2-9363-328F0F478DCC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger2_L_rotateZ";
	rename -uid "4F575AB7-47C1-0CFF-AEED-77A96F17ED2C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_L_translateX";
	rename -uid "977E2307-43DD-854B-314A-5086354AFAB3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_L_translateY";
	rename -uid "D6CB0645-41C5-E5D1-0B42-B6B5FA530CA2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger2_L_translateZ";
	rename -uid "4AF5BEF9-4BAB-95CF-651C-0796BFAE0A2A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKNeck_M_rotateX";
	rename -uid "E80DB753-49D4-79B3-B294-0EB54D98A16F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKNeck_M_rotateY";
	rename -uid "E75E62AA-422B-7039-FBDA-3FA748FA6A30";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKNeck_M_rotateZ";
	rename -uid "50FF656F-4C3B-C81F-2883-D481B85DF3B6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKNeck_M_translateX";
	rename -uid "25DC628B-4E94-F112-C337-E68E894C6AD2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKNeck_M_translateY";
	rename -uid "9CF287A9-42BE-B8F6-582E-7C85C2D68C1F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKNeck_M_translateZ";
	rename -uid "715DEF14-4250-9CAB-3100-53A0BB5D07CB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "AimEye_M_rotateX";
	rename -uid "4EF69556-4A2B-A118-CE01-2988670AE340";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "AimEye_M_rotateY";
	rename -uid "E1520B15-4D02-B574-5DE5-429A0CE4594E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "AimEye_M_rotateZ";
	rename -uid "449B0D6F-4BFF-5E59-C4CA-0BA9F012ACD2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_M_translateX";
	rename -uid "80AE52F3-44D7-A4C6-910F-D682B6DF7347";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_M_translateY";
	rename -uid "A98D6BD7-4075-ACFA-5FD9-9590EC73BF57";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "AimEye_M_translateZ";
	rename -uid "FF29D416-486D-88B1-5D26-DC9136CF6C58";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKEye_R_rotateX";
	rename -uid "670BE9BE-4118-DCA0-5B6E-288CBA0C5EF6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKEye_R_rotateY";
	rename -uid "25E64CB3-463F-F0B4-9016-75888FB91FC0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKEye_R_rotateZ";
	rename -uid "5987D441-4AD8-A48D-FAA4-35B56694272C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_R_translateX";
	rename -uid "2AE5945B-4891-4B54-C6CE-7D8BA4C9CB13";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_R_translateY";
	rename -uid "068336D1-4239-2C67-60E0-B39159D3998A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKEye_R_translateZ";
	rename -uid "D10164CF-40E5-2AE2-D0AF-758007C57B7B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger3_R_rotateX";
	rename -uid "BDDB2381-4D9D-06AB-0F6F-B887A992A972";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger3_R_rotateY";
	rename -uid "4FC1A84C-40DE-6B31-A4CD-C1B4D7BD3B65";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger3_R_rotateZ";
	rename -uid "6F1F1AB3-4E36-9295-3FB2-F9B5858A133B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_R_translateX";
	rename -uid "A09AA53F-49AD-1A00-6B83-9482D6119C2E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_R_translateY";
	rename -uid "2648C2AF-4566-961E-03B1-8596C4AD9D67";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_R_translateZ";
	rename -uid "4D83941D-4984-3DB4-E0B1-83AD170B9FBF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine3_M_rotateX";
	rename -uid "0FA6673C-4452-2957-069F-1E9A1C3E5A5A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine3_M_rotateY";
	rename -uid "69103907-434D-B408-6288-FD9AAA6B45A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridExtraSpine3_M_rotateZ";
	rename -uid "47CAE2E8-4860-DF8D-A1F9-17B099C8150E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine3_M_translateX";
	rename -uid "3B8C97D2-4A10-341F-5A3B-99944F0747D5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine3_M_translateY";
	rename -uid "2D967668-44D9-AC65-82D8-63812D6DCE0E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridExtraSpine3_M_translateZ";
	rename -uid "AE5FA151-4C93-3CDB-1A4B-E18C1AE46326";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_R_rotateX";
	rename -uid "A8C8A423-4233-136B-B764-C6A76F0C7422";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_R_rotateY";
	rename -uid "02205052-4D27-7B17-CF42-D8A3640F26C6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_R_rotateZ";
	rename -uid "D8866BA1-42C4-33CF-89CB-919B6C63F21A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_R_translateX";
	rename -uid "B22480B9-4071-60A3-E235-4083E4D903C1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_R_translateY";
	rename -uid "624FEF83-4778-E142-4CF8-2CA1CEDAFC5E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_R_translateZ";
	rename -uid "C774552B-44DE-FE8F-663A-DDB3A15CD901";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_R_rotateX";
	rename -uid "6FD41DE3-4DCE-3E6F-DF10-218048407CD5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_R_rotateY";
	rename -uid "841696FD-4477-C4D2-1A8B-F2B4E4F29339";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_R_rotateZ";
	rename -uid "A0A23F71-40D7-45FB-3F04-6EB10DB27D82";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_R_translateX";
	rename -uid "3AE2967D-45DF-C1A0-22EF-3B9E073E6004";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_R_translateY";
	rename -uid "2E4653D6-4E9D-6EFB-7C81-55A0C07DB043";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_R_translateZ";
	rename -uid "D19A80D0-43EB-DF8D-3737-4BAC5DE611F0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_L_rotateX";
	rename -uid "18DAA1D5-477E-01C3-9258-128264D2BA81";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_L_rotateY";
	rename -uid "6E8B2EB6-49C5-1277-9CD4-89BDF6FFA622";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_L_rotateZ";
	rename -uid "A00A95AE-4ED4-F520-675E-DEA65FA2C3B7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_L_translateX";
	rename -uid "0F0E5E84-4CA4-6481-B64A-6FAD9C9D3D0A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_L_translateY";
	rename -uid "85BAB11C-438D-1007-372C-EF948ED78027";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_L_translateZ";
	rename -uid "DE46F538-4559-C9B4-6F5D-9BBB86E1BB12";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_R_rotateX";
	rename -uid "B336495A-474C-0A90-2C1B-F4A2F09793FC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_R_rotateY";
	rename -uid "49297584-4EF9-4427-E42E-00958BF082DC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraToes_R_rotateZ";
	rename -uid "493C9E4F-461D-9E0F-136A-5C96CEC5BB06";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_R_translateX";
	rename -uid "B2614632-4D36-1BC9-F840-DC91C4B20E7B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_R_translateY";
	rename -uid "66362A1E-4E68-41EB-4129-8AA50723D325";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraToes_R_translateZ";
	rename -uid "8D7BA0ED-4F38-A2D9-F80E-6691F638C0D3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTU -n "FKIKSpine_M_FKIKBlend";
	rename -uid "2D98650F-40F0-1AE6-0405-DFA6D3647122";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_L_rotateX";
	rename -uid "4D318E9F-44E8-0C9B-CA48-E0B84FA41296";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_L_rotateY";
	rename -uid "0D1ECEE1-448B-E596-26A7-BEB1137FA6DB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger2_L_rotateZ";
	rename -uid "B2A85AC3-4EFA-7F46-EB7E-B79DFFE43D56";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_L_translateX";
	rename -uid "9DD23975-45EE-3F94-94D8-61835EDB3997";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_L_translateY";
	rename -uid "591C044F-4854-9063-AF01-C4BE348017CF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger2_L_translateZ";
	rename -uid "570283E8-4AD8-0A86-BCB8-518650FBB43E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_R_rotateX";
	rename -uid "EA8AD1CB-4283-E056-81BB-FF99E485C216";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_R_rotateY";
	rename -uid "0B0A469F-4E41-A883-8BC6-8A8161F9F504";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_R_rotateZ";
	rename -uid "5308621C-4743-475B-D0BF-EA8C540D0540";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_R_translateX";
	rename -uid "AC13B63D-43E4-0005-6DB1-10886C959B17";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_R_translateY";
	rename -uid "1AB597DA-40B2-FD51-B0E1-7A9E37351DB2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_R_translateZ";
	rename -uid "61277F8D-4B98-8D15-579C-539931294371";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKSpine1_M_rotateX";
	rename -uid "E47C675C-4AEA-BB3C-78F7-6FB3EA7D0A33";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKSpine1_M_rotateY";
	rename -uid "9EA9946E-4D4A-15FE-5303-A3828FC97BBE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKSpine1_M_rotateZ";
	rename -uid "58858346-46CA-0F85-61B4-92A41DBC2B89";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine1_M_translateX";
	rename -uid "87B8E439-46E4-66C5-5D1B-27B2CA830F3B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine1_M_translateY";
	rename -uid "E0966BB5-4497-482A-D655-CC88F4D7BCA6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKSpine1_M_translateZ";
	rename -uid "1FDFF023-4E72-90C2-B7C3-56B743261B04";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger2_R_rotateX";
	rename -uid "02F74692-49FB-C0F1-378C-FC8B7A232E2A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger2_R_rotateY";
	rename -uid "26856823-42D6-8FB8-3263-CD8CA53FA893";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger2_R_rotateZ";
	rename -uid "B118F8FE-4B39-DBA6-959C-A9A3323EB688";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger2_R_translateX";
	rename -uid "BC55CEED-4375-C8A9-1ED7-D2B95D2C19DA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 9.7699626169999993e-15 145 9.7699626169999993e-15;
createNode animCurveTL -n "FKExtraThumbFinger2_R_translateY";
	rename -uid "80F00FB0-440E-E153-017B-38B1CDD4B24B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.842170943e-14 145 -2.842170943e-14;
createNode animCurveTL -n "FKExtraThumbFinger2_R_translateZ";
	rename -uid "6555E60A-4816-C6BF-0BDC-D2A9482927FD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.4210854719999998e-14 145 1.4210854719999998e-14;
createNode animCurveTA -n "FKExtraHead_M_rotateX";
	rename -uid "9C22D82C-4204-C009-310F-29978DB172B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHead_M_rotateY";
	rename -uid "8506B601-4A51-E0CC-319A-DB8E391D1E00";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHead_M_rotateZ";
	rename -uid "F1CBED42-4BCF-3EFF-3D6C-10A81BF3BE17";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHead_M_translateX";
	rename -uid "B0886DC6-4658-293D-3A8B-12A7EBE8C25A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHead_M_translateY";
	rename -uid "C32857EA-48E1-39B2-10E4-DBAF68CB8B5B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHead_M_translateZ";
	rename -uid "2D99A338-42C9-98F3-ACF9-688490323596";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_R_rotateX";
	rename -uid "12F056CA-4A7C-7B00-B23F-FDBAB85E1409";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_R_rotateY";
	rename -uid "646A4704-43ED-A70D-A5DE-928C30E69D81";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_R_rotateZ";
	rename -uid "BF4E3C2B-45F8-1F9D-FF9F-258FE8827BCA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_R_translateX";
	rename -uid "72316DDD-4859-995B-F854-A38397F9DA57";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_R_translateY";
	rename -uid "C008DAEF-44B4-FD9A-5BAE-FBB595F944BD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_R_translateZ";
	rename -uid "CD2A7491-4D72-6596-2497-998C3AB81C64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_L_rotateX";
	rename -uid "DE57FEB7-4A11-ACC9-28D6-74B7A793CE58";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_L_rotateY";
	rename -uid "9D8ADDF1-4361-20BC-2251-B795C00CC396";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraLeg_L_rotateZ";
	rename -uid "DD98CF49-4FC1-CE14-F8BA-F88D0698E5F0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_L_translateX";
	rename -uid "93D19840-411E-160A-0E64-D58DFF77375F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_L_translateY";
	rename -uid "DC871AA1-4450-4D85-7E38-4883F7358B1B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraLeg_L_translateZ";
	rename -uid "2C04FEFD-4754-EDDA-6C81-D38A14B7811D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_L_rotateX";
	rename -uid "B0AA1E67-40F8-C405-9EFB-FC98AC8CF1DE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_L_rotateY";
	rename -uid "261FFC6E-4F8F-6BCA-3E4B-4D9DE11AEA76";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKScapula_L_rotateZ";
	rename -uid "10EE11E7-4F0C-4F9E-01D4-E2AA7BA4DDF9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_L_translateX";
	rename -uid "D8E6B193-4870-BB73-52DD-4BA6B2E02F02";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_L_translateY";
	rename -uid "CE120C73-4EBE-878A-6B4A-52B4B0A9F662";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKScapula_L_translateZ";
	rename -uid "F4EAB621-4EB7-9DA6-29A1-9C955E267429";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine1_M_rotateX";
	rename -uid "1B62761E-4FCA-D3E5-4D11-B9ADCF669C28";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine1_M_rotateY";
	rename -uid "0EE2F1B2-48D5-7B51-EDF9-2991F966B5BF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine1_M_rotateZ";
	rename -uid "CBA9B29F-4740-082A-C052-5BAD3EA8023F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine1_M_translateX";
	rename -uid "9E0FF3F1-47FF-7164-E998-A6A907D159B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine1_M_translateY";
	rename -uid "103D636F-464D-B3E2-E0A4-7C96FBA05E8F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine1_M_translateZ";
	rename -uid "FFC50059-4E07-5E7A-C542-FE94B7E098ED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_R_rotateX";
	rename -uid "DE05DD63-4C03-BA3C-FCFD-B682248E9702";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_R_rotateY";
	rename -uid "44941713-48B7-AF37-37C8-79ADB9637A08";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_R_rotateZ";
	rename -uid "1A8C85BB-4F18-11A1-E7A3-1CA8E0769630";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_R_translateX";
	rename -uid "3D6BE52E-42F2-0A64-3691-4E8DFCC9CCB6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_R_translateY";
	rename -uid "D2CE7E60-4E0D-0CD2-05DC-62992DADA3A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_R_translateZ";
	rename -uid "3656CEB1-4E5A-3EAF-784A-9BA9ECAB8CDD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine2_M_rotateX";
	rename -uid "629D603A-46C9-E7B0-A5B5-8FAB81A6E8C3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine2_M_rotateY";
	rename -uid "84B6E26F-49D1-F3B3-F035-D9B07C190688";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtraSpine2_M_rotateZ";
	rename -uid "54063A68-4C19-031B-D4B8-5BB0A9803A1C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine2_M_translateX";
	rename -uid "36380FA7-4219-13FB-AC99-39B0DB6829D3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine2_M_translateY";
	rename -uid "E261300A-4685-CA21-3E79-BE88595C642D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtraSpine2_M_translateZ";
	rename -uid "D2832516-44BD-7457-40BF-8BB420F66FB2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_L_rotateX";
	rename -uid "0D1DDA8D-44E0-2B2D-FCB1-409B718892F3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_L_rotateY";
	rename -uid "B01F6764-4667-6A06-F06F-FF85AEB4DE5F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_L_rotateZ";
	rename -uid "36C4D46B-4354-21A1-C814-5BBF3A180830";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_L_translateX";
	rename -uid "6E6B501E-48E2-FFDB-0F2F-E69E22BF46E8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_L_translateY";
	rename -uid "ABDFB5C8-49E2-1858-B966-3DA0158C1D1D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_L_translateZ";
	rename -uid "E5843A1C-4F6D-B4C8-DE3F-1E8A203AD42D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_R_rotateX";
	rename -uid "8E546620-4B6F-0405-BD05-B18DF1F9CDB0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_R_rotateY";
	rename -uid "2EFA5DEB-443B-6BE5-C29F-26A61C755CCE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_R_rotateZ";
	rename -uid "65F6ECD8-4E24-5D58-C51B-95BBD58734ED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger1_R_translateX";
	rename -uid "070651EA-4E23-2E51-ED1C-D48DFBD6086E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.4210854719999998e-14 145 -1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraRingFinger1_R_translateY";
	rename -uid "783448C0-4242-DC8C-A084-23804895B41D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.9984014440000001e-15 145 -1.9984014440000001e-15;
createNode animCurveTL -n "FKExtraRingFinger1_R_translateZ";
	rename -uid "825FE1EB-49AF-C9F3-96A8-EB96C5F9A9BA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.842170943e-14 145 -2.842170943e-14;
createNode animCurveTA -n "IKArm_R_rotateX";
	rename -uid "3957C0A2-4D7A-4A8F-EB54-529C23E4B176";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKArm_R_rotateY";
	rename -uid "9AEC53B5-4876-37FC-57A1-D1AF17B711D9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKArm_R_rotateZ";
	rename -uid "8B812007-4713-28B1-195B-FC8120F0165A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKArm_R_translateX";
	rename -uid "F61E2996-4F52-6EDB-F904-CF840F9624C1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKArm_R_translateY";
	rename -uid "016BB9A3-456E-32A8-E28B-F8872EC84661";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKArm_R_translateZ";
	rename -uid "36F91FD0-403F-4B49-64F3-8992586ED597";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine2_M_rotateX";
	rename -uid "E7E2E8BA-41CF-3D45-FA2C-41A86C8C300D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine2_M_rotateY";
	rename -uid "76136910-4662-1E8C-C156-1A84140946FF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKExtracvSpine2_M_rotateZ";
	rename -uid "F1785785-4A86-44B3-A05F-78BE0E47119B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine2_M_translateX";
	rename -uid "FE2F952E-487B-0A97-F47C-5F828CDEB90B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine2_M_translateY";
	rename -uid "6D687F3D-430F-7406-2BA8-35BD33E97EC2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKExtracvSpine2_M_translateZ";
	rename -uid "36F6B8C6-440B-DC66-6C72-128AB9F27B26";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_L_rotateX";
	rename -uid "A5C2BA07-4526-1E55-980E-1996DAFC979E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_L_rotateY";
	rename -uid "F1FD44B0-488E-D569-058E-C483ABDEB339";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_L_rotateZ";
	rename -uid "56FD7DBF-493A-8864-E625-FD88F373FF91";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_L_translateX";
	rename -uid "9E5950BD-4B8C-5856-2218-CA8F0995A27D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_L_translateY";
	rename -uid "173D8675-4783-6A4B-2B98-3CBF91B7BBFA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_L_translateZ";
	rename -uid "80DA8D8E-403D-D61E-4777-7DA322089B7E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_R_rotateX";
	rename -uid "94CF0003-4BA4-14A5-F542-FEB9F8E13F95";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_R_rotateY";
	rename -uid "C1733A75-41B8-F124-6690-48AB4773358E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraElbow_R_rotateZ";
	rename -uid "3121D834-49CB-6C38-6CFA-CA897DC51B12";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_R_translateX";
	rename -uid "E5AED46C-48A6-5335-44E1-CD9CF3CACB05";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_R_translateY";
	rename -uid "62D79675-4768-B811-FEF9-58B550BCE739";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraElbow_R_translateZ";
	rename -uid "B128DDF9-4F43-4BDD-67A0-A593F14A0E46";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKcvSpine1_M_translateX";
	rename -uid "402F1B1D-45B0-154E-311D-23B6C4184D73";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKcvSpine1_M_translateY";
	rename -uid "48C6BFF1-404E-DCD4-1C04-26A6B3B0EC18";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKcvSpine1_M_translateZ";
	rename -uid "37F4668A-4562-F985-4E4D-A7A66B5C7328";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_R_rotateX";
	rename -uid "A3BB094F-4F6B-9354-FF7C-D1B6EF1099B5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_R_rotateY";
	rename -uid "C0F72ABA-439F-56A6-9075-8FB794A7CCF4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKKnee_R_rotateZ";
	rename -uid "5C2A56C8-44B4-2B5E-3BD6-259D3CAEB34E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_R_translateX";
	rename -uid "EA214013-4DFD-578B-7EB4-EEA836A6E634";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_R_translateY";
	rename -uid "4F9B4FE4-4655-2DFF-917D-12B377C55E05";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKKnee_R_translateZ";
	rename -uid "C04F30AE-49ED-091D-7DE1-D7B2FC717B65";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_R_rotateX";
	rename -uid "F9381767-4658-B3EE-6FBD-B981D47AB884";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_R_rotateY";
	rename -uid "EDCCDCD0-45BB-2D0B-85E1-2BABA213EEF9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKIndexFinger1_R_rotateZ";
	rename -uid "23E8D4E7-4DFE-E8ED-0DF4-AAA4A9D0EEED";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_R_translateX";
	rename -uid "B9973BA3-46C8-3C61-86E8-7F939C350C54";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_R_translateY";
	rename -uid "8CCB2CED-4BDA-9B07-8411-F397616733A3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKIndexFinger1_R_translateZ";
	rename -uid "0BF567D2-404D-F353-C375-3DAA6EEEAF14";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_L_rotateX";
	rename -uid "14FD0302-4220-D36C-63AE-8B845698F0EA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_L_rotateY";
	rename -uid "D608815B-4A9B-3BBE-4DE8-8D84FEA0706C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraRingFinger1_L_rotateZ";
	rename -uid "A430AA61-4DDE-D223-967B-7688F8DD9B82";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraRingFinger1_L_translateX";
	rename -uid "95644FBF-4345-66BE-9711-3488C2A0286B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.4210854715202004e-14 145 1.4210854715202004e-14;
createNode animCurveTL -n "FKExtraRingFinger1_L_translateY";
	rename -uid "61F39088-4102-76E1-CDC7-228B94424211";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 3.1086244689504383e-15 145 3.1086244689504383e-15;
createNode animCurveTL -n "FKExtraRingFinger1_L_translateZ";
	rename -uid "2AB7F9EE-4EF3-8BA0-D719-348F5BAA72B4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraJaw_M_rotateX";
	rename -uid "090AE280-41F7-F326-1B05-8E9D5FE72754";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraJaw_M_rotateY";
	rename -uid "FD7737A0-44DB-0DCF-0214-4086A4B118A6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraJaw_M_rotateZ";
	rename -uid "D59FBAF5-48EE-341C-8A54-D9B3CBC2FB9C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraJaw_M_translateX";
	rename -uid "26DA3E18-4CB7-606E-8CFB-49B5C6FD6EB9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraJaw_M_translateY";
	rename -uid "B9F83042-4064-89C0-17F2-EFAC12C18C50";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraJaw_M_translateZ";
	rename -uid "ABF4D290-42E8-8109-BF21-4FB5D3C570D4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_R_rotateX";
	rename -uid "11DFFB09-4182-3A38-16CF-78AC0C059F02";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_R_rotateY";
	rename -uid "9EE79820-459A-59A2-C52E-D9A9A55930A6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraShoulder_R_rotateZ";
	rename -uid "C2BF0837-4CAD-6EFC-CEA4-589BB488E48F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_R_translateX";
	rename -uid "C3C3992E-414E-F608-327B-04BFD9BE0F9A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_R_translateY";
	rename -uid "4132C146-430D-9412-F566-3EB72B90BFC2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraShoulder_R_translateZ";
	rename -uid "D621B226-4E46-E66B-0CD7-FEA189AEF450";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_L_rotateX";
	rename -uid "EF69C22E-4261-E47D-3BBE-288ACAA18E9D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_L_rotateY";
	rename -uid "374CE47C-4690-5324-B636-4AA3265F5039";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraScapula_L_rotateZ";
	rename -uid "CDDAC54B-42FE-5312-1669-0797BA4EE6C7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_L_translateX";
	rename -uid "0EC5690A-473D-399C-9ECD-9A9BD0F397DE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_L_translateY";
	rename -uid "7352B379-4CDF-EFAA-5FD9-189FEE86D37E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraScapula_L_translateZ";
	rename -uid "7DAC11C4-4F93-22BB-B6F8-8E930C4710D2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_R_rotateX";
	rename -uid "0DCDE7E5-4977-83BD-4268-8D8AC9F9F3B3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_R_rotateY";
	rename -uid "4C58888B-40E9-506F-2034-4FB9DB4EFFB8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_R_rotateZ";
	rename -uid "CD38C141-4306-3881-95FE-29989E876D2C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_R_translateX";
	rename -uid "87747730-4E62-F51D-425C-3283F3672D3B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_R_translateY";
	rename -uid "C994ECFA-44B1-739B-6C67-EB887F428424";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_R_translateZ";
	rename -uid "FD17CD55-4D71-8F21-7722-6EA580F3F6C7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHip_R_rotateX";
	rename -uid "3E91471C-47F4-CB1B-4115-2B851DAE6895";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHip_R_rotateY";
	rename -uid "58716EB4-4FE3-2B08-EC5B-C1AF016B92FD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHip_R_rotateZ";
	rename -uid "B669AD3E-4A70-8A57-8D1D-8086A77793D8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_R_translateX";
	rename -uid "96CDA4A4-42D2-3F3A-4A0F-AB8F7F6527FE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_R_translateY";
	rename -uid "760F410C-432A-86E7-7C3A-E38FAE0489BB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_R_translateZ";
	rename -uid "21149F0A-4011-6317-1A3D-E2A9CE60AE63";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_L_rotateX";
	rename -uid "A30D238A-4CFD-56F7-D4E6-70B59AB225BE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_L_rotateY";
	rename -uid "54856D3B-4401-6009-3A73-4480EE1E7011";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger1_L_rotateZ";
	rename -uid "32D429BB-43D3-2534-7496-478481691DDA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_L_translateX";
	rename -uid "A3034C11-4654-0550-9078-5880E1A30127";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_L_translateY";
	rename -uid "AC17D83A-47DD-F65E-AC25-BEA87BD33D87";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger1_L_translateZ";
	rename -uid "F52DC76C-4ED5-F38B-F082-F2A158E58AC7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_R_rotateX";
	rename -uid "70AC9290-43AF-7F17-D8BB-35810DF393CD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_R_rotateY";
	rename -uid "840D94DF-4F86-D564-6621-D09EA0F88C18";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraThumbFinger3_R_rotateZ";
	rename -uid "487FCEAA-4544-7792-F646-7FA5637080F0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraThumbFinger3_R_translateX";
	rename -uid "7E0C5164-455D-739F-EC59-E7ACDBC27A32";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -4.4408920990000004e-15 145 -4.4408920990000004e-15;
createNode animCurveTL -n "FKExtraThumbFinger3_R_translateY";
	rename -uid "E63C8E6C-4D41-4D88-9EAF-F98343E1BCA9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.842170943e-14 145 -2.842170943e-14;
createNode animCurveTL -n "FKExtraThumbFinger3_R_translateZ";
	rename -uid "9E4ADC74-480C-6714-20DE-058688B2AE53";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_L_rotateX";
	rename -uid "A59ACC54-4957-6772-4736-4B8749E6CCB3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_L_rotateY";
	rename -uid "04F2B4AA-40A2-B3D1-3E0D-888569B97860";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger1_L_rotateZ";
	rename -uid "8A870540-40AA-A3CE-11A6-A8969539DEA2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger1_L_translateX";
	rename -uid "8AF0241B-436E-5B3B-B3F4-60A253612913";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -7.1054273576010019e-15 145 -7.1054273576010019e-15;
createNode animCurveTL -n "FKExtraIndexFinger1_L_translateY";
	rename -uid "61F50E23-4E87-CA8F-8A0A-8B978798F514";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 3.5527136788005009e-15 145 3.5527136788005009e-15;
createNode animCurveTL -n "FKExtraIndexFinger1_L_translateZ";
	rename -uid "F9DBC034-4E3F-2741-5D09-7992FCBF6B70";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.8421709430404007e-14 145 2.8421709430404007e-14;
createNode animCurveTA -n "FKExtraHip_L_rotateX";
	rename -uid "8A1B8C94-43D7-401A-067E-35A82BD5B276";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHip_L_rotateY";
	rename -uid "9DD88BD6-432B-85BE-6117-1B9E5D18E6F8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraHip_L_rotateZ";
	rename -uid "8B822379-4F3D-5E3E-4771-BA8DC01AD51C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_L_translateX";
	rename -uid "CD4A65AE-4F14-441A-3251-C0AC6BF6AB87";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_L_translateY";
	rename -uid "F2C9B68D-4092-13B8-2D8A-48A95B3D08A7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraHip_L_translateZ";
	rename -uid "E4668914-4BB3-0C1D-D1F2-D4804FCAFBD8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_L_rotateX";
	rename -uid "4D254421-4B49-35CB-E768-85B8CA1C6CA9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_L_rotateY";
	rename -uid "5ACC2130-40DB-4AA3-518A-9EA1E374C384";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKThumbFinger2_L_rotateZ";
	rename -uid "BE63ED7A-4882-5BEE-32A5-BC8A0E794AD6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_L_translateX";
	rename -uid "DA542167-4854-80CD-17FD-4FA614A37B9F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_L_translateY";
	rename -uid "BD7BA0B7-414C-BC18-55DF-08B48CF473CC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKThumbFinger2_L_translateZ";
	rename -uid "13109D9F-4B38-3AB7-9714-CA8D84261709";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine1_M_rotateX";
	rename -uid "6DDF9144-4E3B-8541-4E7B-C881560459B4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine1_M_rotateY";
	rename -uid "3C4C6AAF-4540-95A3-909D-99B1FA02F6AD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraSpine1_M_rotateZ";
	rename -uid "2A936885-41B0-DDF7-5787-A697153DAE22";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraSpine1_M_translateX";
	rename -uid "2D3AB500-4920-15E0-4CD1-DD9C4CB152E8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraSpine1_M_translateY";
	rename -uid "0310A98F-487A-0F54-A548-A28913DEB9F1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 8.881784197e-16 145 8.881784197e-16;
createNode animCurveTL -n "FKExtraSpine1_M_translateZ";
	rename -uid "5A201DD4-46DC-096C-9BB6-39B39C7993B7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 3.1554436210000005e-30 145 3.1554436210000005e-30;
createNode animCurveTA -n "FKRingFinger3_L_rotateX";
	rename -uid "530A83B4-486F-75D9-364E-C2A37CDCBBCA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger3_L_rotateY";
	rename -uid "8D8DD22C-4796-910E-645E-70926BB6A790";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKRingFinger3_L_rotateZ";
	rename -uid "007B1B80-4B25-5BF2-D048-1E8A233B6155";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_L_translateX";
	rename -uid "FCD4D274-45C3-4FF2-914F-8296FCC1236B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_L_translateY";
	rename -uid "075FDD0E-4EB6-BC8D-7860-9B9F8CB9921C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKRingFinger3_L_translateZ";
	rename -uid "59470E02-4DE0-07CE-61DB-9CB66773A6FC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "HipSwinger_M_rotateX";
	rename -uid "881DD982-498F-19F0-BACD-9AA5D181EA4D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "HipSwinger_M_rotateY";
	rename -uid "7D41823D-4BBB-2856-4E4B-5A980DD33EBE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "HipSwinger_M_rotateZ";
	rename -uid "358A5CD9-4A63-EDB6-A9AE-06A89C5D1268";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKElbow_R_rotateX";
	rename -uid "55F71DE1-4F40-5673-D0BB-DEB9FBCC6C21";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKElbow_R_rotateY";
	rename -uid "2BE8F252-4018-177A-2B60-28B1402B8CCE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKElbow_R_rotateZ";
	rename -uid "8D73E9BA-49E0-41D4-A041-FBB23D57B6E7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKElbow_R_translateX";
	rename -uid "6057062D-4105-8458-C162-2C9BAA882F08";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKElbow_R_translateY";
	rename -uid "379DD44A-4F38-B5DE-DAC5-D198AD57D599";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKElbow_R_translateZ";
	rename -uid "033E0B50-485C-339F-318E-91BB4FF6774A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_L_rotateX";
	rename -uid "C077ECB5-4C48-7035-0EAF-A09B155AD8D9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_L_rotateY";
	rename -uid "C0EA3791-41F2-66AE-B68B-DDB337C61BBD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_L_rotateZ";
	rename -uid "9E53D9FA-45B1-D3DF-19B4-EAB41C4B98AB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_L_translateX";
	rename -uid "6BE627E5-4EA9-D3F5-7394-D589DFC51E72";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_L_translateY";
	rename -uid "2F8FDB3B-464A-D795-FF15-1D996C2AC64A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_L_translateZ";
	rename -uid "B1ED5746-4EC0-EC2F-BB6C-57B3AC621C64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_R_translateX";
	rename -uid "883AE17E-4DEB-B57C-27A7-6E88D322BCD2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_R_translateY";
	rename -uid "EED92C34-42A5-F4B3-8397-FB9FC216D80E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_R_translateZ";
	rename -uid "CEB9D2AA-4425-63A9-E922-C68669F29162";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraNeck_M_rotateX";
	rename -uid "A252CE7F-42A6-3F7A-26D8-75937C564E7F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraNeck_M_rotateY";
	rename -uid "9D285124-482E-CC17-18F3-C59BE976ACAC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraNeck_M_rotateZ";
	rename -uid "973E3B31-499B-525A-E740-60B80531397C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraNeck_M_translateX";
	rename -uid "AF1CD993-473A-9E29-A9B3-F588D07DE307";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraNeck_M_translateY";
	rename -uid "82DCE21D-464C-085F-76AC-289E3B5BB0B8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraNeck_M_translateZ";
	rename -uid "77DD8C6E-46C7-5EAD-8AD5-3E9EED28BA7E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_L_translateX";
	rename -uid "90E1014B-41B1-1911-5E9F-5A96CEAF2F46";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_L_translateY";
	rename -uid "6BD076B4-4727-BF2E-E171-3C8DC61D73AB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "PoleLeg_L_translateZ";
	rename -uid "02BF17BB-4653-3378-13B6-469554F34ABF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_R_rotateX";
	rename -uid "B88824C7-4541-07CC-3278-3F8041EE4CB5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_R_rotateY";
	rename -uid "1886EDE8-4389-DDEC-BEE4-0F9FFB7D2E3C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKHip_R_rotateZ";
	rename -uid "5EBA114D-48AA-A146-4503-C095844281D1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_R_translateX";
	rename -uid "079EFC5D-4B61-E560-B0CF-5EB009B657DC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_R_translateY";
	rename -uid "12CE1723-4158-8646-0913-C6ADDCB34436";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKHip_R_translateZ";
	rename -uid "FEFD09A2-421A-303A-A0A2-A1927ACABF7C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKElbow_L_rotateX";
	rename -uid "FA97B743-4F43-4C4D-A7BC-BAAD6990A87D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.2722217173537617e-14 145 1.2722217173537617e-14;
createNode animCurveTA -n "FKElbow_L_rotateY";
	rename -uid "0FC9FDD9-41C5-7D26-C28E-C581C00EC8C0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -7.653212282745105e-15 145 -7.653212282745105e-15;
createNode animCurveTA -n "FKElbow_L_rotateZ";
	rename -uid "49B91AB4-4CA8-C02B-AAC8-868D4C365C3F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.3242840523795935e-05 145 -2.3242840523795935e-05;
createNode animCurveTL -n "FKElbow_L_translateX";
	rename -uid "0CBFBAA0-42BE-046F-4F29-809D1F4C8E19";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 4.5293532480172871e-08 145 4.5293532480172871e-08;
createNode animCurveTL -n "FKElbow_L_translateY";
	rename -uid "9D60FBB5-4BF8-4BE9-2C0A-DDAD3F983B68";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -5.0662052331063023e-09 145 -5.0662052331063023e-09;
createNode animCurveTL -n "FKElbow_L_translateZ";
	rename -uid "B7973F5E-4753-63F8-2C39-F68E781CAAFA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTA -n "FKExtraWrist_R_rotateX";
	rename -uid "A0EBAD00-49A8-9C03-872F-5A9D579C0829";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraWrist_R_rotateY";
	rename -uid "7BF1CE9B-48BA-F8F2-C02F-59B00097E4A4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraWrist_R_rotateZ";
	rename -uid "153652BE-4D5F-00E7-0489-9484422FCAB5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_R_translateX";
	rename -uid "61611D02-481D-1EE2-FE97-678CCDE47F7C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_R_translateY";
	rename -uid "D4E99947-4AA9-2894-58A6-5C8E4525AC7D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_R_translateZ";
	rename -uid "D821BFCF-4AEA-E8F0-885B-14A3BDD7C6F8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_L_rotateX";
	rename -uid "0B369C1E-4A5C-D0D3-355C-E7A2C9A67A83";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_L_rotateY";
	rename -uid "ED720D7A-4255-9846-7488-FBB49A1092F7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_L_rotateZ";
	rename -uid "44EA2897-4883-7E71-7C31-4994BF1E42FA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_L_translateX";
	rename -uid "5BBC7AB9-4EE7-F36C-09B8-4BBB7842B57B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_L_translateY";
	rename -uid "F08E87A6-4925-26DF-C0D3-7D9F69178D55";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_L_translateZ";
	rename -uid "583E542C-46A8-7E6C-8ED3-268D92D30E3F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine3_M_rotateX";
	rename -uid "2631F7D3-40B4-A074-A885-D693B17094A2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine3_M_rotateY";
	rename -uid "B11904A0-4FF1-EBA0-2055-B29AF5AB5791";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine3_M_rotateZ";
	rename -uid "4F9FAF00-4102-2391-C058-65BC9F8AC211";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine3_M_translateX";
	rename -uid "E11924AB-46DA-1D43-E654-19B49A7F3D46";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine3_M_translateY";
	rename -uid "9FBF693A-4F9B-E1F0-F43E-ACB29D561D2D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine3_M_translateZ";
	rename -uid "D90FF367-4423-CF96-E935-3D95D27FE0EC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_L_rotateX";
	rename -uid "50B0F422-4921-88A1-490F-C78E4C83234B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_L_rotateY";
	rename -uid "56E1219C-45BC-0338-5981-52B1B528C97B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_L_rotateZ";
	rename -uid "5B864FE5-4430-85BD-6EEC-10B882A1F48F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_L_translateX";
	rename -uid "B0A79BBD-41B9-4326-6083-CDBF4855D34C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_L_translateY";
	rename -uid "A378BE91-40B7-7A56-1B14-4EA67904AEA5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_L_translateZ";
	rename -uid "851DF3F6-4BEE-F471-EEA8-A7B2EA26093B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_R_rotateX";
	rename -uid "D560EBA2-4C42-3B8D-4F47-CC972AA67818";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_R_rotateY";
	rename -uid "963F1BCA-47E4-3E16-7922-1D962DD2AF99";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraEye_R_rotateZ";
	rename -uid "78BFD414-4CDD-5C07-6EF4-B7A8B251F779";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_R_translateX";
	rename -uid "0158D351-4F4C-1962-1A52-729875D0A528";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_R_translateY";
	rename -uid "09F43C6F-4233-C59B-00B7-4D80D541482B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraEye_R_translateZ";
	rename -uid "7F37E93E-427A-DEB1-521D-C8ADADA5D396";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_R_rotateX";
	rename -uid "3CBCBD0D-4646-127C-C0D8-33A69A422601";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_R_rotateY";
	rename -uid "CFD58C73-4AC5-54E7-29D6-339747877C7B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraAnkle_R_rotateZ";
	rename -uid "E75C2A68-4C41-A181-1873-7EAA17704D33";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_R_translateX";
	rename -uid "16A6A09D-4752-B366-12CE-CD8986CF8F64";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_R_translateY";
	rename -uid "4C5A8CBA-42B5-5E0F-2F43-D7B72E88C9B8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraAnkle_R_translateZ";
	rename -uid "5F3DCB13-4ABE-907B-02B6-938674BE169A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_R_rotateX";
	rename -uid "17F61262-49D1-E6FC-10CE-B98BFEBDAAFB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_R_rotateY";
	rename -uid "926BED92-43D6-719F-7892-CA8169573886";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_R_rotateZ";
	rename -uid "0904D720-4F74-600E-F713-FD9BC3BF2227";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger2_R_translateX";
	rename -uid "E9E54DD6-4FAA-634D-B279-34834DE5F411";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 7.1054273579999998e-15 145 7.1054273579999998e-15;
createNode animCurveTL -n "FKExtraPinkyFinger2_R_translateY";
	rename -uid "02745D62-4E26-7AE1-B987-AB88B9529413";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 5.3290705179999997e-15 145 5.3290705179999997e-15;
createNode animCurveTL -n "FKExtraPinkyFinger2_R_translateZ";
	rename -uid "4A5521F2-4B8A-B738-0C65-B2B6EF3AB19C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.842170943e-14 145 2.842170943e-14;
createNode animCurveTA -n "IKhybridSpine1_M_rotateX";
	rename -uid "5C59902B-4510-9ABF-9E41-7D8A5835D801";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine1_M_rotateY";
	rename -uid "7A55F91A-4BF0-46AF-B879-DCA3B2E7C65D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "IKhybridSpine1_M_rotateZ";
	rename -uid "88357E3E-48D6-8A32-AF23-3AA13123289B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine1_M_translateX";
	rename -uid "810150EB-4763-5E3C-DDC5-2483148EF82B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine1_M_translateY";
	rename -uid "86776E12-4CDF-7871-DEA4-CC8775F89B1C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKhybridSpine1_M_translateZ";
	rename -uid "60B84053-44C4-85A3-AD81-6AADAB8A459F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraWrist_L_rotateX";
	rename -uid "8B41CF66-4C03-E164-059B-47B968E07345";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraWrist_L_rotateY";
	rename -uid "4AA25014-4163-A511-AD79-DC9F80FA6D6C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraWrist_L_rotateZ";
	rename -uid "BC56E692-4BC2-588D-C9B2-AAA6957E2D26";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_L_translateX";
	rename -uid "D86B7105-4054-D8D2-FAB3-D399E7E262C6";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_L_translateY";
	rename -uid "59831E03-4D40-EC97-EF4F-A987F8F709DF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraWrist_L_translateZ";
	rename -uid "510BB9A2-4F81-204A-860B-408705665841";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_R_rotateX";
	rename -uid "0EA2718D-4450-A92E-5DC9-1FB841C6E0C8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_R_rotateY";
	rename -uid "E9EEBE21-4DE7-0841-AA00-0ABE51F3DEB4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKMiddleFinger2_R_rotateZ";
	rename -uid "196CA5C3-4F2E-E06C-FD6C-95862B454165";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_R_translateX";
	rename -uid "011E21C0-4D3F-CA58-9242-A8A8DCA3C8E7";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_R_translateY";
	rename -uid "68444BD5-4242-192A-A213-3C90416CA4A4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKMiddleFinger2_R_translateZ";
	rename -uid "3D44491A-4AC3-BBCD-1B55-3AB5B5A65C36";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKWrist_L_rotateX";
	rename -uid "242DA7F8-4CFA-4586-DBEB-0797817D3120";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.7890620789345792e-14 145 1.7890620789345792e-14;
createNode animCurveTA -n "FKWrist_L_rotateY";
	rename -uid "7FE4B807-4654-15D7-837B-83BB1C46099C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -6.5202904600610058e-15 145 -6.5202904600610058e-15;
createNode animCurveTA -n "FKWrist_L_rotateZ";
	rename -uid "39C8501D-4ECB-0AE9-8C9B-E2876873C424";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.2409667388279275e-05 145 1.2409667388279275e-05;
createNode animCurveTL -n "FKWrist_L_translateX";
	rename -uid "DCD7FB59-44F4-3738-D9B6-3D85D4C45E1D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 2.3001096849384339e-07 145 2.3001096849384339e-07;
createNode animCurveTL -n "FKWrist_L_translateY";
	rename -uid "0526035F-46B4-C55D-DE04-A6A2291DCC58";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.2635302581998076e-08 145 1.2635302581998076e-08;
createNode animCurveTL -n "FKWrist_L_translateZ";
	rename -uid "E98E47BF-42FC-2BFB-75BC-3D9FFC72DD87";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_L_rotateX";
	rename -uid "6C91B352-4550-D83F-D8E8-43B32CC06DF9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_L_rotateY";
	rename -uid "53F63CDF-4113-5003-60CA-CAA0C24B026A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraPinkyFinger2_L_rotateZ";
	rename -uid "B4A98028-4D01-DD17-FA63-F085523DDDA3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraPinkyFinger2_L_translateX";
	rename -uid "CFD065BD-4A19-EB82-4119-3498D2E9A5EE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.1316282072803006e-14 145 -2.1316282072803006e-14;
createNode animCurveTL -n "FKExtraPinkyFinger2_L_translateY";
	rename -uid "85A22C6B-4D6E-8029-72E7-A186348D7445";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -1.7763568394002505e-15 145 -1.7763568394002505e-15;
createNode animCurveTL -n "FKExtraPinkyFinger2_L_translateZ";
	rename -uid "C937EE58-4752-6A91-F68E-1987B0DC8098";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTA -n "FKExtraIndexFinger3_R_rotateX";
	rename -uid "AD9C08EF-47BF-C0BF-603C-49B23FCEEB0D";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger3_R_rotateY";
	rename -uid "8B8783A3-4310-5C2A-6FEB-F1BBBDCCAF7C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger3_R_rotateZ";
	rename -uid "04ED51D4-4D41-8628-8E6A-0EAD867AE7CD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger3_R_translateX";
	rename -uid "589F0687-46A2-1786-949E-9DBE3478E04C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 1.4210854719999998e-14 145 1.4210854719999998e-14;
createNode animCurveTL -n "FKExtraIndexFinger3_R_translateY";
	rename -uid "EFA0FBC4-44CB-5725-D7B7-1DB6735FB1B2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -3.5527136789999999e-15 145 -3.5527136789999999e-15;
createNode animCurveTL -n "FKExtraIndexFinger3_R_translateZ";
	rename -uid "3362396D-4E66-FCB0-25F4-809B20E28549";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_L_rotateX";
	rename -uid "F264A5FD-4C2B-DE85-44FE-E5BEE1C6CA02";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_L_rotateY";
	rename -uid "084281FC-4A37-82AB-C5C5-58B2F12705E1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger2_L_rotateZ";
	rename -uid "E1476CC5-4D6D-C7E7-C2E8-CA97775C46E2";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_L_translateX";
	rename -uid "1FF661B1-4835-AA67-0E69-16AE797A9BB3";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_L_translateY";
	rename -uid "DFCECC31-406B-4B27-FC2A-C69E53962BFD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger2_L_translateZ";
	rename -uid "82544F37-427B-5B01-EDE5-7FA900F9FEF1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger3_L_rotateX";
	rename -uid "70009CA9-4FE5-6F02-2AB5-CFABA9C7B83B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger3_L_rotateY";
	rename -uid "6FA6BF96-4DA5-BCF9-9335-0DB19745160B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKExtraIndexFinger3_L_rotateZ";
	rename -uid "28F74C4B-40D3-ABD8-2B97-71862255B45C";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKExtraIndexFinger3_L_translateX";
	rename -uid "7CA1DB1B-4C69-2513-3BA9-F38682E0CC19";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -2.8421709430404007e-14 145 -2.8421709430404007e-14;
createNode animCurveTL -n "FKExtraIndexFinger3_L_translateY";
	rename -uid "1FA8457A-4661-7834-7BFC-AB8C94CEFFAC";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 -3.5527136788005009e-15 145 -3.5527136788005009e-15;
createNode animCurveTL -n "FKExtraIndexFinger3_L_translateZ";
	rename -uid "A503F421-4160-BDBD-0099-3D9541690AC0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTU -n "FKIKLeg_L_FKIKBlend";
	rename -uid "376FC9D3-40F1-9C27-55D8-2CA842F6F5A9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 10 145 10;
createNode animCurveTL -n "IKcvSpine2_M_translateX";
	rename -uid "4FFFDBDE-47D8-F065-65D2-559C3143A168";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKcvSpine2_M_translateY";
	rename -uid "DC854700-45BC-8D08-E817-99BCB037CBE5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "IKcvSpine2_M_translateZ";
	rename -uid "71091DA6-4839-9424-F44D-DBA9CEB1B3DF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKWrist_R_rotateX";
	rename -uid "2F40B7D2-4970-8018-138F-E79A8DD3D647";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKWrist_R_rotateY";
	rename -uid "A48CBE4A-4CCC-7A9F-337B-E6B4E4020393";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKWrist_R_rotateZ";
	rename -uid "8AD766CB-4D73-F03D-A451-8E8BCB1B2D06";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKWrist_R_translateX";
	rename -uid "D56CA113-4CA1-2A0F-87DD-9C9B86314FAA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKWrist_R_translateY";
	rename -uid "71311CDF-4A13-8AB2-BFE8-C999A1F6E73F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKWrist_R_translateZ";
	rename -uid "2564F6C2-4C2A-8B04-CB24-8C84B190C3C9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_L_rotateX";
	rename -uid "9A658E2F-428D-AACE-69E4-5D801EB57F8F";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_L_rotateY";
	rename -uid "0D2A272C-4244-670F-6BE0-618C6F1023A5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "RollToesEnd_L_rotateZ";
	rename -uid "7A56A9D1-47B9-1D53-DE99-77BBF39670C8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_L_translateX";
	rename -uid "A4F8DB87-4114-850C-B80F-BDB325F40804";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_L_translateY";
	rename -uid "0E4BE632-4DC4-86EF-F01D-5FA98F93CDBE";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "RollToesEnd_L_translateZ";
	rename -uid "7BB8E10D-4B17-68BB-5610-B1A19971ED20";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_L_rotateX";
	rename -uid "F0686DCF-42D5-BFCD-4BE3-4FB27C3E9ECA";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_L_rotateY";
	rename -uid "B95F3B1B-4DD5-4582-9083-AA990A2C16A5";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTA -n "FKToes_L_rotateZ";
	rename -uid "0C289A87-4FC4-E3A8-F741-678F22C5D0FD";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_L_translateX";
	rename -uid "99660F4D-436D-BD15-22D4-2EBB9629715A";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_L_translateY";
	rename -uid "06B0CC7E-4004-3CC1-0C70-52B62483571B";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
createNode animCurveTL -n "FKToes_L_translateZ";
	rename -uid "CFD3A8BC-46C4-5E03-2570-478BB23EFE77";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  105 0 145 0;
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -av -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 105;
	setAttr -av -k on ".unw" 105;
	setAttr -av -k on ".etw";
	setAttr -av -k on ".tps";
	setAttr -av -k on ".tms";
select -ne :hardwareRenderingGlobals;
	setAttr -k on ".ihi";
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr -av ".ta";
	setAttr -av ".tq";
	setAttr -av ".aoam";
	setAttr -av ".aora";
	setAttr -av ".mbe";
	setAttr -av -k on ".mbsof";
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
	setAttr -k on ".ihi";
	setAttr -s 4 ".r";
select -ne :initialShadingGroup;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
select -ne :initialParticleSE;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -cb on ".macc";
	setAttr -cb on ".macd";
	setAttr -cb on ".macq";
	setAttr -k on ".mcfr";
	setAttr -cb on ".ifg";
	setAttr -k on ".clip";
	setAttr -k on ".edm";
	setAttr -av -k on ".edl";
	setAttr -cb on ".ren" -type "string" "arnold";
	setAttr -av -k on ".esr";
	setAttr -k on ".ors";
	setAttr -cb on ".sdf";
	setAttr -av -k on ".outf";
	setAttr -av -cb on ".imfkey";
	setAttr -av -k on ".gama";
	setAttr -av -k on ".an";
	setAttr -cb on ".ar";
	setAttr -av -k on ".bfs";
	setAttr -cb on ".me";
	setAttr -cb on ".se";
	setAttr -av -k on ".be";
	setAttr -av -cb on ".ep";
	setAttr -k on ".fec";
	setAttr -av -k on ".ofc";
	setAttr -cb on ".ofe";
	setAttr -cb on ".efe";
	setAttr -cb on ".oft";
	setAttr -cb on ".umfn";
	setAttr -cb on ".ufe";
	setAttr -av -cb on ".pff";
	setAttr -av -cb on ".peie";
	setAttr -av -cb on ".ifp";
	setAttr -k on ".rv";
	setAttr -k on ".comp";
	setAttr -k on ".cth";
	setAttr -k on ".soll";
	setAttr -cb on ".sosl";
	setAttr -k on ".rd";
	setAttr -k on ".lp";
	setAttr -av -k on ".sp";
	setAttr -k on ".shs";
	setAttr -av -k on ".lpr";
	setAttr -cb on ".gv";
	setAttr -cb on ".sv";
	setAttr -k on ".mm";
	setAttr -k on ".npu";
	setAttr -cb on ".itf";
	setAttr -k on ".shp";
	setAttr -cb on ".isp";
	setAttr -k on ".uf";
	setAttr -k on ".oi";
	setAttr -k on ".rut";
	setAttr -k on ".mot";
	setAttr -av -cb on ".mb";
	setAttr -av -k on ".mbf";
	setAttr -k on ".mbso";
	setAttr -k on ".mbsc";
	setAttr -av -k on ".afp";
	setAttr -k on ".pfb";
	setAttr -k on ".pram";
	setAttr -k on ".poam";
	setAttr -k on ".prlm";
	setAttr -k on ".polm";
	setAttr -cb on ".prm";
	setAttr -cb on ".pom";
	setAttr -cb on ".pfrm";
	setAttr -cb on ".pfom";
	setAttr -av -k on ".bll";
	setAttr -av -k on ".bls";
	setAttr -av -k on ".smv";
	setAttr -k on ".ubc";
	setAttr -k on ".mbc";
	setAttr -cb on ".mbt";
	setAttr -k on ".udbx";
	setAttr -k on ".smc";
	setAttr -k on ".kmv";
	setAttr -cb on ".isl";
	setAttr -cb on ".ism";
	setAttr -cb on ".imb";
	setAttr -av -k on ".rlen";
	setAttr -av -k on ".frts";
	setAttr -k on ".tlwd";
	setAttr -k on ".tlht";
	setAttr -cb on ".jfc";
	setAttr -cb on ".rsb";
	setAttr -cb on ".ope";
	setAttr -cb on ".oppf";
	setAttr -av -k on ".rcp";
	setAttr -av -k on ".icp";
	setAttr -av -k on ".ocp";
	setAttr -cb on ".hbl";
select -ne :defaultResolution;
	setAttr -av -k on ".cch";
	setAttr -av -k on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av -k on ".w";
	setAttr -av -k on ".h";
	setAttr -av -k on ".pa" 1;
	setAttr -av -k on ".al";
	setAttr -av -k on ".dar";
	setAttr -av -k on ".ldar";
	setAttr -av -k on ".dpi";
	setAttr -av -k on ".off";
	setAttr -av -k on ".fld";
	setAttr -av -k on ".zsl";
	setAttr -av -k on ".isu";
	setAttr -av -k on ".pdu";
select -ne :hardwareRenderGlobals;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k off -cb on ".ctrs" 256;
	setAttr -av -k off -cb on ".btrs" 512;
	setAttr -k off -cb on ".fbfm";
	setAttr -k off -cb on ".ehql";
	setAttr -k off -cb on ".eams";
	setAttr -k off -cb on ".eeaa";
	setAttr -k off -cb on ".engm";
	setAttr -k off -cb on ".mes";
	setAttr -k off -cb on ".emb";
	setAttr -av -k off -cb on ".mbbf";
	setAttr -k off -cb on ".mbs";
	setAttr -k off -cb on ".trm";
	setAttr -k off -cb on ".tshc";
	setAttr -k off -cb on ".enpt";
	setAttr -k off -cb on ".clmt";
	setAttr -k off -cb on ".tcov";
	setAttr -k off -cb on ".lith";
	setAttr -k off -cb on ".sobc";
	setAttr -k off -cb on ".cuth";
	setAttr -k off -cb on ".hgcd";
	setAttr -k off -cb on ".hgci";
	setAttr -k off -cb on ".mgcs";
	setAttr -k off -cb on ".twa";
	setAttr -k off -cb on ".twz";
	setAttr -k on ".hwcc";
	setAttr -k on ".hwdp";
	setAttr -k on ".hwql";
	setAttr -k on ".hwfr";
	setAttr -k on ".soll";
	setAttr -k on ".sosl";
	setAttr -k on ".bswa";
	setAttr -k on ".shml";
	setAttr -k on ".hwel";
select -ne :ikSystem;
	setAttr -k on ".cch";
	setAttr -k on ".ihi";
	setAttr -k on ".nds";
	setAttr -k on ".bnm";
	setAttr -av -k on ".gsn";
	setAttr -k on ".gsv";
	setAttr -s 3 ".sol";
connectAttr "Main_translateX.o" "ManRN.phl[1]";
connectAttr "Main_translateY.o" "ManRN.phl[2]";
connectAttr "Main_translateZ.o" "ManRN.phl[3]";
connectAttr "Main_rotateX.o" "ManRN.phl[4]";
connectAttr "Main_rotateY.o" "ManRN.phl[5]";
connectAttr "Main_rotateZ.o" "ManRN.phl[6]";
connectAttr "FKExtraRoot_M_translateX.o" "ManRN.phl[7]";
connectAttr "FKExtraRoot_M_translateY.o" "ManRN.phl[8]";
connectAttr "FKExtraRoot_M_translateZ.o" "ManRN.phl[9]";
connectAttr "FKExtraRoot_M_rotateX.o" "ManRN.phl[10]";
connectAttr "FKExtraRoot_M_rotateY.o" "ManRN.phl[11]";
connectAttr "FKExtraRoot_M_rotateZ.o" "ManRN.phl[12]";
connectAttr "FKRoot_M_translateX.o" "ManRN.phl[13]";
connectAttr "FKRoot_M_translateY.o" "ManRN.phl[14]";
connectAttr "FKRoot_M_translateZ.o" "ManRN.phl[15]";
connectAttr "FKRoot_M_rotateX.o" "ManRN.phl[16]";
connectAttr "FKRoot_M_rotateY.o" "ManRN.phl[17]";
connectAttr "FKRoot_M_rotateZ.o" "ManRN.phl[18]";
connectAttr "FKExtraSpine1_M_translateX.o" "ManRN.phl[19]";
connectAttr "FKExtraSpine1_M_translateY.o" "ManRN.phl[20]";
connectAttr "FKExtraSpine1_M_translateZ.o" "ManRN.phl[21]";
connectAttr "FKExtraSpine1_M_rotateX.o" "ManRN.phl[22]";
connectAttr "FKExtraSpine1_M_rotateY.o" "ManRN.phl[23]";
connectAttr "FKExtraSpine1_M_rotateZ.o" "ManRN.phl[24]";
connectAttr "FKSpine1_M_translateX.o" "ManRN.phl[25]";
connectAttr "FKSpine1_M_translateY.o" "ManRN.phl[26]";
connectAttr "FKSpine1_M_translateZ.o" "ManRN.phl[27]";
connectAttr "FKSpine1_M_rotateX.o" "ManRN.phl[28]";
connectAttr "FKSpine1_M_rotateY.o" "ManRN.phl[29]";
connectAttr "FKSpine1_M_rotateZ.o" "ManRN.phl[30]";
connectAttr "FKExtraSpine2_M_translateX.o" "ManRN.phl[31]";
connectAttr "FKExtraSpine2_M_translateY.o" "ManRN.phl[32]";
connectAttr "FKExtraSpine2_M_translateZ.o" "ManRN.phl[33]";
connectAttr "FKExtraSpine2_M_rotateX.o" "ManRN.phl[34]";
connectAttr "FKExtraSpine2_M_rotateY.o" "ManRN.phl[35]";
connectAttr "FKExtraSpine2_M_rotateZ.o" "ManRN.phl[36]";
connectAttr "FKSpine2_M_translateX.o" "ManRN.phl[37]";
connectAttr "FKSpine2_M_translateY.o" "ManRN.phl[38]";
connectAttr "FKSpine2_M_translateZ.o" "ManRN.phl[39]";
connectAttr "FKSpine2_M_rotateX.o" "ManRN.phl[40]";
connectAttr "FKSpine2_M_rotateY.o" "ManRN.phl[41]";
connectAttr "FKSpine2_M_rotateZ.o" "ManRN.phl[42]";
connectAttr "FKExtraChest_M_translateX.o" "ManRN.phl[43]";
connectAttr "FKExtraChest_M_translateY.o" "ManRN.phl[44]";
connectAttr "FKExtraChest_M_translateZ.o" "ManRN.phl[45]";
connectAttr "FKExtraChest_M_rotateX.o" "ManRN.phl[46]";
connectAttr "FKExtraChest_M_rotateY.o" "ManRN.phl[47]";
connectAttr "FKExtraChest_M_rotateZ.o" "ManRN.phl[48]";
connectAttr "FKChest_M_translateX.o" "ManRN.phl[49]";
connectAttr "FKChest_M_translateY.o" "ManRN.phl[50]";
connectAttr "FKChest_M_translateZ.o" "ManRN.phl[51]";
connectAttr "FKChest_M_rotateX.o" "ManRN.phl[52]";
connectAttr "FKChest_M_rotateY.o" "ManRN.phl[53]";
connectAttr "FKChest_M_rotateZ.o" "ManRN.phl[54]";
connectAttr "HipSwinger_M_rotateX.o" "ManRN.phl[55]";
connectAttr "HipSwinger_M_rotateY.o" "ManRN.phl[56]";
connectAttr "HipSwinger_M_rotateZ.o" "ManRN.phl[57]";
connectAttr "FKExtraNeck_M_translateX.o" "ManRN.phl[58]";
connectAttr "FKExtraNeck_M_translateY.o" "ManRN.phl[59]";
connectAttr "FKExtraNeck_M_translateZ.o" "ManRN.phl[60]";
connectAttr "FKExtraNeck_M_rotateX.o" "ManRN.phl[61]";
connectAttr "FKExtraNeck_M_rotateY.o" "ManRN.phl[62]";
connectAttr "FKExtraNeck_M_rotateZ.o" "ManRN.phl[63]";
connectAttr "FKNeck_M_translateX.o" "ManRN.phl[64]";
connectAttr "FKNeck_M_translateY.o" "ManRN.phl[65]";
connectAttr "FKNeck_M_translateZ.o" "ManRN.phl[66]";
connectAttr "FKNeck_M_rotateX.o" "ManRN.phl[67]";
connectAttr "FKNeck_M_rotateY.o" "ManRN.phl[68]";
connectAttr "FKNeck_M_rotateZ.o" "ManRN.phl[69]";
connectAttr "FKExtraHead_M_translateX.o" "ManRN.phl[70]";
connectAttr "FKExtraHead_M_translateY.o" "ManRN.phl[71]";
connectAttr "FKExtraHead_M_translateZ.o" "ManRN.phl[72]";
connectAttr "FKExtraHead_M_rotateX.o" "ManRN.phl[73]";
connectAttr "FKExtraHead_M_rotateY.o" "ManRN.phl[74]";
connectAttr "FKExtraHead_M_rotateZ.o" "ManRN.phl[75]";
connectAttr "FKHead_M_translateX.o" "ManRN.phl[76]";
connectAttr "FKHead_M_translateY.o" "ManRN.phl[77]";
connectAttr "FKHead_M_translateZ.o" "ManRN.phl[78]";
connectAttr "FKHead_M_rotateX.o" "ManRN.phl[79]";
connectAttr "FKHead_M_rotateY.o" "ManRN.phl[80]";
connectAttr "FKHead_M_rotateZ.o" "ManRN.phl[81]";
connectAttr "FKExtraJaw_M_translateX.o" "ManRN.phl[82]";
connectAttr "FKExtraJaw_M_translateY.o" "ManRN.phl[83]";
connectAttr "FKExtraJaw_M_translateZ.o" "ManRN.phl[84]";
connectAttr "FKExtraJaw_M_rotateX.o" "ManRN.phl[85]";
connectAttr "FKExtraJaw_M_rotateY.o" "ManRN.phl[86]";
connectAttr "FKExtraJaw_M_rotateZ.o" "ManRN.phl[87]";
connectAttr "FKJaw_M_translateX.o" "ManRN.phl[88]";
connectAttr "FKJaw_M_translateY.o" "ManRN.phl[89]";
connectAttr "FKJaw_M_translateZ.o" "ManRN.phl[90]";
connectAttr "FKJaw_M_rotateX.o" "ManRN.phl[91]";
connectAttr "FKJaw_M_rotateY.o" "ManRN.phl[92]";
connectAttr "FKJaw_M_rotateZ.o" "ManRN.phl[93]";
connectAttr "FKExtraEye_R_translateX.o" "ManRN.phl[94]";
connectAttr "FKExtraEye_R_translateY.o" "ManRN.phl[95]";
connectAttr "FKExtraEye_R_translateZ.o" "ManRN.phl[96]";
connectAttr "FKExtraEye_R_rotateX.o" "ManRN.phl[97]";
connectAttr "FKExtraEye_R_rotateY.o" "ManRN.phl[98]";
connectAttr "FKExtraEye_R_rotateZ.o" "ManRN.phl[99]";
connectAttr "FKEye_R_translateX.o" "ManRN.phl[100]";
connectAttr "FKEye_R_translateY.o" "ManRN.phl[101]";
connectAttr "FKEye_R_translateZ.o" "ManRN.phl[102]";
connectAttr "FKEye_R_rotateX.o" "ManRN.phl[103]";
connectAttr "FKEye_R_rotateY.o" "ManRN.phl[104]";
connectAttr "FKEye_R_rotateZ.o" "ManRN.phl[105]";
connectAttr "FKExtraEye_L_translateX.o" "ManRN.phl[106]";
connectAttr "FKExtraEye_L_translateY.o" "ManRN.phl[107]";
connectAttr "FKExtraEye_L_translateZ.o" "ManRN.phl[108]";
connectAttr "FKExtraEye_L_rotateX.o" "ManRN.phl[109]";
connectAttr "FKExtraEye_L_rotateY.o" "ManRN.phl[110]";
connectAttr "FKExtraEye_L_rotateZ.o" "ManRN.phl[111]";
connectAttr "FKEye_L_translateX.o" "ManRN.phl[112]";
connectAttr "FKEye_L_translateY.o" "ManRN.phl[113]";
connectAttr "FKEye_L_translateZ.o" "ManRN.phl[114]";
connectAttr "FKEye_L_rotateX.o" "ManRN.phl[115]";
connectAttr "FKEye_L_rotateY.o" "ManRN.phl[116]";
connectAttr "FKEye_L_rotateZ.o" "ManRN.phl[117]";
connectAttr "FKExtraScapula_R_translateX.o" "ManRN.phl[118]";
connectAttr "FKExtraScapula_R_translateY.o" "ManRN.phl[119]";
connectAttr "FKExtraScapula_R_translateZ.o" "ManRN.phl[120]";
connectAttr "FKExtraScapula_R_rotateX.o" "ManRN.phl[121]";
connectAttr "FKExtraScapula_R_rotateY.o" "ManRN.phl[122]";
connectAttr "FKExtraScapula_R_rotateZ.o" "ManRN.phl[123]";
connectAttr "FKScapula_R_translateX.o" "ManRN.phl[124]";
connectAttr "FKScapula_R_translateY.o" "ManRN.phl[125]";
connectAttr "FKScapula_R_translateZ.o" "ManRN.phl[126]";
connectAttr "FKScapula_R_rotateX.o" "ManRN.phl[127]";
connectAttr "FKScapula_R_rotateY.o" "ManRN.phl[128]";
connectAttr "FKScapula_R_rotateZ.o" "ManRN.phl[129]";
connectAttr "FKExtraScapula_L_translateX.o" "ManRN.phl[130]";
connectAttr "FKExtraScapula_L_translateY.o" "ManRN.phl[131]";
connectAttr "FKExtraScapula_L_translateZ.o" "ManRN.phl[132]";
connectAttr "FKExtraScapula_L_rotateX.o" "ManRN.phl[133]";
connectAttr "FKExtraScapula_L_rotateY.o" "ManRN.phl[134]";
connectAttr "FKExtraScapula_L_rotateZ.o" "ManRN.phl[135]";
connectAttr "FKScapula_L_translateX.o" "ManRN.phl[136]";
connectAttr "FKScapula_L_translateY.o" "ManRN.phl[137]";
connectAttr "FKScapula_L_translateZ.o" "ManRN.phl[138]";
connectAttr "FKScapula_L_rotateX.o" "ManRN.phl[139]";
connectAttr "FKScapula_L_rotateY.o" "ManRN.phl[140]";
connectAttr "FKScapula_L_rotateZ.o" "ManRN.phl[141]";
connectAttr "FKExtraMiddleFinger1_R_translateX.o" "ManRN.phl[142]";
connectAttr "FKExtraMiddleFinger1_R_translateY.o" "ManRN.phl[143]";
connectAttr "FKExtraMiddleFinger1_R_translateZ.o" "ManRN.phl[144]";
connectAttr "FKExtraMiddleFinger1_R_rotateX.o" "ManRN.phl[145]";
connectAttr "FKExtraMiddleFinger1_R_rotateY.o" "ManRN.phl[146]";
connectAttr "FKExtraMiddleFinger1_R_rotateZ.o" "ManRN.phl[147]";
connectAttr "FKMiddleFinger1_R_translateX.o" "ManRN.phl[148]";
connectAttr "FKMiddleFinger1_R_translateY.o" "ManRN.phl[149]";
connectAttr "FKMiddleFinger1_R_translateZ.o" "ManRN.phl[150]";
connectAttr "FKMiddleFinger1_R_rotateX.o" "ManRN.phl[151]";
connectAttr "FKMiddleFinger1_R_rotateY.o" "ManRN.phl[152]";
connectAttr "FKMiddleFinger1_R_rotateZ.o" "ManRN.phl[153]";
connectAttr "FKExtraMiddleFinger2_R_translateX.o" "ManRN.phl[154]";
connectAttr "FKExtraMiddleFinger2_R_translateY.o" "ManRN.phl[155]";
connectAttr "FKExtraMiddleFinger2_R_translateZ.o" "ManRN.phl[156]";
connectAttr "FKExtraMiddleFinger2_R_rotateX.o" "ManRN.phl[157]";
connectAttr "FKExtraMiddleFinger2_R_rotateY.o" "ManRN.phl[158]";
connectAttr "FKExtraMiddleFinger2_R_rotateZ.o" "ManRN.phl[159]";
connectAttr "FKMiddleFinger2_R_translateX.o" "ManRN.phl[160]";
connectAttr "FKMiddleFinger2_R_translateY.o" "ManRN.phl[161]";
connectAttr "FKMiddleFinger2_R_translateZ.o" "ManRN.phl[162]";
connectAttr "FKMiddleFinger2_R_rotateX.o" "ManRN.phl[163]";
connectAttr "FKMiddleFinger2_R_rotateY.o" "ManRN.phl[164]";
connectAttr "FKMiddleFinger2_R_rotateZ.o" "ManRN.phl[165]";
connectAttr "FKExtraMiddleFinger3_R_translateX.o" "ManRN.phl[166]";
connectAttr "FKExtraMiddleFinger3_R_translateY.o" "ManRN.phl[167]";
connectAttr "FKExtraMiddleFinger3_R_translateZ.o" "ManRN.phl[168]";
connectAttr "FKExtraMiddleFinger3_R_rotateX.o" "ManRN.phl[169]";
connectAttr "FKExtraMiddleFinger3_R_rotateY.o" "ManRN.phl[170]";
connectAttr "FKExtraMiddleFinger3_R_rotateZ.o" "ManRN.phl[171]";
connectAttr "FKMiddleFinger3_R_translateX.o" "ManRN.phl[172]";
connectAttr "FKMiddleFinger3_R_translateY.o" "ManRN.phl[173]";
connectAttr "FKMiddleFinger3_R_translateZ.o" "ManRN.phl[174]";
connectAttr "FKMiddleFinger3_R_rotateX.o" "ManRN.phl[175]";
connectAttr "FKMiddleFinger3_R_rotateY.o" "ManRN.phl[176]";
connectAttr "FKMiddleFinger3_R_rotateZ.o" "ManRN.phl[177]";
connectAttr "FKExtraThumbFinger1_R_translateX.o" "ManRN.phl[178]";
connectAttr "FKExtraThumbFinger1_R_translateY.o" "ManRN.phl[179]";
connectAttr "FKExtraThumbFinger1_R_translateZ.o" "ManRN.phl[180]";
connectAttr "FKExtraThumbFinger1_R_rotateX.o" "ManRN.phl[181]";
connectAttr "FKExtraThumbFinger1_R_rotateY.o" "ManRN.phl[182]";
connectAttr "FKExtraThumbFinger1_R_rotateZ.o" "ManRN.phl[183]";
connectAttr "FKThumbFinger1_R_translateX.o" "ManRN.phl[184]";
connectAttr "FKThumbFinger1_R_translateY.o" "ManRN.phl[185]";
connectAttr "FKThumbFinger1_R_translateZ.o" "ManRN.phl[186]";
connectAttr "FKThumbFinger1_R_rotateX.o" "ManRN.phl[187]";
connectAttr "FKThumbFinger1_R_rotateY.o" "ManRN.phl[188]";
connectAttr "FKThumbFinger1_R_rotateZ.o" "ManRN.phl[189]";
connectAttr "FKExtraThumbFinger2_R_translateX.o" "ManRN.phl[190]";
connectAttr "FKExtraThumbFinger2_R_translateY.o" "ManRN.phl[191]";
connectAttr "FKExtraThumbFinger2_R_translateZ.o" "ManRN.phl[192]";
connectAttr "FKExtraThumbFinger2_R_rotateX.o" "ManRN.phl[193]";
connectAttr "FKExtraThumbFinger2_R_rotateY.o" "ManRN.phl[194]";
connectAttr "FKExtraThumbFinger2_R_rotateZ.o" "ManRN.phl[195]";
connectAttr "FKThumbFinger2_R_translateX.o" "ManRN.phl[196]";
connectAttr "FKThumbFinger2_R_translateY.o" "ManRN.phl[197]";
connectAttr "FKThumbFinger2_R_translateZ.o" "ManRN.phl[198]";
connectAttr "FKThumbFinger2_R_rotateX.o" "ManRN.phl[199]";
connectAttr "FKThumbFinger2_R_rotateY.o" "ManRN.phl[200]";
connectAttr "FKThumbFinger2_R_rotateZ.o" "ManRN.phl[201]";
connectAttr "FKExtraThumbFinger3_R_translateX.o" "ManRN.phl[202]";
connectAttr "FKExtraThumbFinger3_R_translateY.o" "ManRN.phl[203]";
connectAttr "FKExtraThumbFinger3_R_translateZ.o" "ManRN.phl[204]";
connectAttr "FKExtraThumbFinger3_R_rotateX.o" "ManRN.phl[205]";
connectAttr "FKExtraThumbFinger3_R_rotateY.o" "ManRN.phl[206]";
connectAttr "FKExtraThumbFinger3_R_rotateZ.o" "ManRN.phl[207]";
connectAttr "FKThumbFinger3_R_translateX.o" "ManRN.phl[208]";
connectAttr "FKThumbFinger3_R_translateY.o" "ManRN.phl[209]";
connectAttr "FKThumbFinger3_R_translateZ.o" "ManRN.phl[210]";
connectAttr "FKThumbFinger3_R_rotateX.o" "ManRN.phl[211]";
connectAttr "FKThumbFinger3_R_rotateY.o" "ManRN.phl[212]";
connectAttr "FKThumbFinger3_R_rotateZ.o" "ManRN.phl[213]";
connectAttr "FKExtraIndexFinger1_R_translateX.o" "ManRN.phl[214]";
connectAttr "FKExtraIndexFinger1_R_translateY.o" "ManRN.phl[215]";
connectAttr "FKExtraIndexFinger1_R_translateZ.o" "ManRN.phl[216]";
connectAttr "FKExtraIndexFinger1_R_rotateX.o" "ManRN.phl[217]";
connectAttr "FKExtraIndexFinger1_R_rotateY.o" "ManRN.phl[218]";
connectAttr "FKExtraIndexFinger1_R_rotateZ.o" "ManRN.phl[219]";
connectAttr "FKIndexFinger1_R_translateX.o" "ManRN.phl[220]";
connectAttr "FKIndexFinger1_R_translateY.o" "ManRN.phl[221]";
connectAttr "FKIndexFinger1_R_translateZ.o" "ManRN.phl[222]";
connectAttr "FKIndexFinger1_R_rotateX.o" "ManRN.phl[223]";
connectAttr "FKIndexFinger1_R_rotateY.o" "ManRN.phl[224]";
connectAttr "FKIndexFinger1_R_rotateZ.o" "ManRN.phl[225]";
connectAttr "FKExtraIndexFinger2_R_translateX.o" "ManRN.phl[226]";
connectAttr "FKExtraIndexFinger2_R_translateY.o" "ManRN.phl[227]";
connectAttr "FKExtraIndexFinger2_R_translateZ.o" "ManRN.phl[228]";
connectAttr "FKExtraIndexFinger2_R_rotateX.o" "ManRN.phl[229]";
connectAttr "FKExtraIndexFinger2_R_rotateY.o" "ManRN.phl[230]";
connectAttr "FKExtraIndexFinger2_R_rotateZ.o" "ManRN.phl[231]";
connectAttr "FKIndexFinger2_R_translateX.o" "ManRN.phl[232]";
connectAttr "FKIndexFinger2_R_translateY.o" "ManRN.phl[233]";
connectAttr "FKIndexFinger2_R_translateZ.o" "ManRN.phl[234]";
connectAttr "FKIndexFinger2_R_rotateX.o" "ManRN.phl[235]";
connectAttr "FKIndexFinger2_R_rotateY.o" "ManRN.phl[236]";
connectAttr "FKIndexFinger2_R_rotateZ.o" "ManRN.phl[237]";
connectAttr "FKExtraIndexFinger3_R_translateX.o" "ManRN.phl[238]";
connectAttr "FKExtraIndexFinger3_R_translateY.o" "ManRN.phl[239]";
connectAttr "FKExtraIndexFinger3_R_translateZ.o" "ManRN.phl[240]";
connectAttr "FKExtraIndexFinger3_R_rotateX.o" "ManRN.phl[241]";
connectAttr "FKExtraIndexFinger3_R_rotateY.o" "ManRN.phl[242]";
connectAttr "FKExtraIndexFinger3_R_rotateZ.o" "ManRN.phl[243]";
connectAttr "FKIndexFinger3_R_translateX.o" "ManRN.phl[244]";
connectAttr "FKIndexFinger3_R_translateY.o" "ManRN.phl[245]";
connectAttr "FKIndexFinger3_R_translateZ.o" "ManRN.phl[246]";
connectAttr "FKIndexFinger3_R_rotateX.o" "ManRN.phl[247]";
connectAttr "FKIndexFinger3_R_rotateY.o" "ManRN.phl[248]";
connectAttr "FKIndexFinger3_R_rotateZ.o" "ManRN.phl[249]";
connectAttr "FKExtraRingFinger1_R_translateX.o" "ManRN.phl[250]";
connectAttr "FKExtraRingFinger1_R_translateY.o" "ManRN.phl[251]";
connectAttr "FKExtraRingFinger1_R_translateZ.o" "ManRN.phl[252]";
connectAttr "FKExtraRingFinger1_R_rotateX.o" "ManRN.phl[253]";
connectAttr "FKExtraRingFinger1_R_rotateY.o" "ManRN.phl[254]";
connectAttr "FKExtraRingFinger1_R_rotateZ.o" "ManRN.phl[255]";
connectAttr "FKRingFinger1_R_translateX.o" "ManRN.phl[256]";
connectAttr "FKRingFinger1_R_translateY.o" "ManRN.phl[257]";
connectAttr "FKRingFinger1_R_translateZ.o" "ManRN.phl[258]";
connectAttr "FKRingFinger1_R_rotateX.o" "ManRN.phl[259]";
connectAttr "FKRingFinger1_R_rotateY.o" "ManRN.phl[260]";
connectAttr "FKRingFinger1_R_rotateZ.o" "ManRN.phl[261]";
connectAttr "FKExtraRingFinger2_R_translateX.o" "ManRN.phl[262]";
connectAttr "FKExtraRingFinger2_R_translateY.o" "ManRN.phl[263]";
connectAttr "FKExtraRingFinger2_R_translateZ.o" "ManRN.phl[264]";
connectAttr "FKExtraRingFinger2_R_rotateX.o" "ManRN.phl[265]";
connectAttr "FKExtraRingFinger2_R_rotateY.o" "ManRN.phl[266]";
connectAttr "FKExtraRingFinger2_R_rotateZ.o" "ManRN.phl[267]";
connectAttr "FKRingFinger2_R_translateX.o" "ManRN.phl[268]";
connectAttr "FKRingFinger2_R_translateY.o" "ManRN.phl[269]";
connectAttr "FKRingFinger2_R_translateZ.o" "ManRN.phl[270]";
connectAttr "FKRingFinger2_R_rotateX.o" "ManRN.phl[271]";
connectAttr "FKRingFinger2_R_rotateY.o" "ManRN.phl[272]";
connectAttr "FKRingFinger2_R_rotateZ.o" "ManRN.phl[273]";
connectAttr "FKExtraRingFinger3_R_translateX.o" "ManRN.phl[274]";
connectAttr "FKExtraRingFinger3_R_translateY.o" "ManRN.phl[275]";
connectAttr "FKExtraRingFinger3_R_translateZ.o" "ManRN.phl[276]";
connectAttr "FKExtraRingFinger3_R_rotateX.o" "ManRN.phl[277]";
connectAttr "FKExtraRingFinger3_R_rotateY.o" "ManRN.phl[278]";
connectAttr "FKExtraRingFinger3_R_rotateZ.o" "ManRN.phl[279]";
connectAttr "FKRingFinger3_R_translateX.o" "ManRN.phl[280]";
connectAttr "FKRingFinger3_R_translateY.o" "ManRN.phl[281]";
connectAttr "FKRingFinger3_R_translateZ.o" "ManRN.phl[282]";
connectAttr "FKRingFinger3_R_rotateX.o" "ManRN.phl[283]";
connectAttr "FKRingFinger3_R_rotateY.o" "ManRN.phl[284]";
connectAttr "FKRingFinger3_R_rotateZ.o" "ManRN.phl[285]";
connectAttr "FKExtraPinkyFinger1_R_translateX.o" "ManRN.phl[286]";
connectAttr "FKExtraPinkyFinger1_R_translateY.o" "ManRN.phl[287]";
connectAttr "FKExtraPinkyFinger1_R_translateZ.o" "ManRN.phl[288]";
connectAttr "FKExtraPinkyFinger1_R_rotateX.o" "ManRN.phl[289]";
connectAttr "FKExtraPinkyFinger1_R_rotateY.o" "ManRN.phl[290]";
connectAttr "FKExtraPinkyFinger1_R_rotateZ.o" "ManRN.phl[291]";
connectAttr "FKPinkyFinger1_R_translateX.o" "ManRN.phl[292]";
connectAttr "FKPinkyFinger1_R_translateY.o" "ManRN.phl[293]";
connectAttr "FKPinkyFinger1_R_translateZ.o" "ManRN.phl[294]";
connectAttr "FKPinkyFinger1_R_rotateX.o" "ManRN.phl[295]";
connectAttr "FKPinkyFinger1_R_rotateY.o" "ManRN.phl[296]";
connectAttr "FKPinkyFinger1_R_rotateZ.o" "ManRN.phl[297]";
connectAttr "FKExtraPinkyFinger2_R_translateX.o" "ManRN.phl[298]";
connectAttr "FKExtraPinkyFinger2_R_translateY.o" "ManRN.phl[299]";
connectAttr "FKExtraPinkyFinger2_R_translateZ.o" "ManRN.phl[300]";
connectAttr "FKExtraPinkyFinger2_R_rotateX.o" "ManRN.phl[301]";
connectAttr "FKExtraPinkyFinger2_R_rotateY.o" "ManRN.phl[302]";
connectAttr "FKExtraPinkyFinger2_R_rotateZ.o" "ManRN.phl[303]";
connectAttr "FKPinkyFinger2_R_translateX.o" "ManRN.phl[304]";
connectAttr "FKPinkyFinger2_R_translateY.o" "ManRN.phl[305]";
connectAttr "FKPinkyFinger2_R_translateZ.o" "ManRN.phl[306]";
connectAttr "FKPinkyFinger2_R_rotateX.o" "ManRN.phl[307]";
connectAttr "FKPinkyFinger2_R_rotateY.o" "ManRN.phl[308]";
connectAttr "FKPinkyFinger2_R_rotateZ.o" "ManRN.phl[309]";
connectAttr "FKExtraPinkyFinger3_R_translateX.o" "ManRN.phl[310]";
connectAttr "FKExtraPinkyFinger3_R_translateY.o" "ManRN.phl[311]";
connectAttr "FKExtraPinkyFinger3_R_translateZ.o" "ManRN.phl[312]";
connectAttr "FKExtraPinkyFinger3_R_rotateX.o" "ManRN.phl[313]";
connectAttr "FKExtraPinkyFinger3_R_rotateY.o" "ManRN.phl[314]";
connectAttr "FKExtraPinkyFinger3_R_rotateZ.o" "ManRN.phl[315]";
connectAttr "FKPinkyFinger3_R_translateX.o" "ManRN.phl[316]";
connectAttr "FKPinkyFinger3_R_translateY.o" "ManRN.phl[317]";
connectAttr "FKPinkyFinger3_R_translateZ.o" "ManRN.phl[318]";
connectAttr "FKPinkyFinger3_R_rotateX.o" "ManRN.phl[319]";
connectAttr "FKPinkyFinger3_R_rotateY.o" "ManRN.phl[320]";
connectAttr "FKPinkyFinger3_R_rotateZ.o" "ManRN.phl[321]";
connectAttr "FKExtraShoulder_R_translateX.o" "ManRN.phl[322]";
connectAttr "FKExtraShoulder_R_translateY.o" "ManRN.phl[323]";
connectAttr "FKExtraShoulder_R_translateZ.o" "ManRN.phl[324]";
connectAttr "FKExtraShoulder_R_rotateX.o" "ManRN.phl[325]";
connectAttr "FKExtraShoulder_R_rotateY.o" "ManRN.phl[326]";
connectAttr "FKExtraShoulder_R_rotateZ.o" "ManRN.phl[327]";
connectAttr "FKShoulder_R_translateX.o" "ManRN.phl[328]";
connectAttr "FKShoulder_R_translateY.o" "ManRN.phl[329]";
connectAttr "FKShoulder_R_translateZ.o" "ManRN.phl[330]";
connectAttr "FKShoulder_R_rotateX.o" "ManRN.phl[331]";
connectAttr "FKShoulder_R_rotateY.o" "ManRN.phl[332]";
connectAttr "FKShoulder_R_rotateZ.o" "ManRN.phl[333]";
connectAttr "FKExtraElbow_R_translateX.o" "ManRN.phl[334]";
connectAttr "FKExtraElbow_R_translateY.o" "ManRN.phl[335]";
connectAttr "FKExtraElbow_R_translateZ.o" "ManRN.phl[336]";
connectAttr "FKExtraElbow_R_rotateX.o" "ManRN.phl[337]";
connectAttr "FKExtraElbow_R_rotateY.o" "ManRN.phl[338]";
connectAttr "FKExtraElbow_R_rotateZ.o" "ManRN.phl[339]";
connectAttr "FKElbow_R_translateX.o" "ManRN.phl[340]";
connectAttr "FKElbow_R_translateY.o" "ManRN.phl[341]";
connectAttr "FKElbow_R_translateZ.o" "ManRN.phl[342]";
connectAttr "FKElbow_R_rotateX.o" "ManRN.phl[343]";
connectAttr "FKElbow_R_rotateY.o" "ManRN.phl[344]";
connectAttr "FKElbow_R_rotateZ.o" "ManRN.phl[345]";
connectAttr "FKExtraWrist_R_translateX.o" "ManRN.phl[346]";
connectAttr "FKExtraWrist_R_translateY.o" "ManRN.phl[347]";
connectAttr "FKExtraWrist_R_translateZ.o" "ManRN.phl[348]";
connectAttr "FKExtraWrist_R_rotateX.o" "ManRN.phl[349]";
connectAttr "FKExtraWrist_R_rotateY.o" "ManRN.phl[350]";
connectAttr "FKExtraWrist_R_rotateZ.o" "ManRN.phl[351]";
connectAttr "FKWrist_R_translateX.o" "ManRN.phl[352]";
connectAttr "FKWrist_R_translateY.o" "ManRN.phl[353]";
connectAttr "FKWrist_R_translateZ.o" "ManRN.phl[354]";
connectAttr "FKWrist_R_rotateX.o" "ManRN.phl[355]";
connectAttr "FKWrist_R_rotateY.o" "ManRN.phl[356]";
connectAttr "FKWrist_R_rotateZ.o" "ManRN.phl[357]";
connectAttr "FKExtraHip_R_translateX.o" "ManRN.phl[358]";
connectAttr "FKExtraHip_R_translateY.o" "ManRN.phl[359]";
connectAttr "FKExtraHip_R_translateZ.o" "ManRN.phl[360]";
connectAttr "FKExtraHip_R_rotateX.o" "ManRN.phl[361]";
connectAttr "FKExtraHip_R_rotateY.o" "ManRN.phl[362]";
connectAttr "FKExtraHip_R_rotateZ.o" "ManRN.phl[363]";
connectAttr "FKHip_R_translateX.o" "ManRN.phl[364]";
connectAttr "FKHip_R_translateY.o" "ManRN.phl[365]";
connectAttr "FKHip_R_translateZ.o" "ManRN.phl[366]";
connectAttr "FKHip_R_rotateX.o" "ManRN.phl[367]";
connectAttr "FKHip_R_rotateY.o" "ManRN.phl[368]";
connectAttr "FKHip_R_rotateZ.o" "ManRN.phl[369]";
connectAttr "FKExtraKnee_R_translateX.o" "ManRN.phl[370]";
connectAttr "FKExtraKnee_R_translateY.o" "ManRN.phl[371]";
connectAttr "FKExtraKnee_R_translateZ.o" "ManRN.phl[372]";
connectAttr "FKExtraKnee_R_rotateX.o" "ManRN.phl[373]";
connectAttr "FKExtraKnee_R_rotateY.o" "ManRN.phl[374]";
connectAttr "FKExtraKnee_R_rotateZ.o" "ManRN.phl[375]";
connectAttr "FKKnee_R_translateX.o" "ManRN.phl[376]";
connectAttr "FKKnee_R_translateY.o" "ManRN.phl[377]";
connectAttr "FKKnee_R_translateZ.o" "ManRN.phl[378]";
connectAttr "FKKnee_R_rotateX.o" "ManRN.phl[379]";
connectAttr "FKKnee_R_rotateY.o" "ManRN.phl[380]";
connectAttr "FKKnee_R_rotateZ.o" "ManRN.phl[381]";
connectAttr "FKExtraAnkle_R_translateX.o" "ManRN.phl[382]";
connectAttr "FKExtraAnkle_R_translateY.o" "ManRN.phl[383]";
connectAttr "FKExtraAnkle_R_translateZ.o" "ManRN.phl[384]";
connectAttr "FKExtraAnkle_R_rotateX.o" "ManRN.phl[385]";
connectAttr "FKExtraAnkle_R_rotateY.o" "ManRN.phl[386]";
connectAttr "FKExtraAnkle_R_rotateZ.o" "ManRN.phl[387]";
connectAttr "FKAnkle_R_translateX.o" "ManRN.phl[388]";
connectAttr "FKAnkle_R_translateY.o" "ManRN.phl[389]";
connectAttr "FKAnkle_R_translateZ.o" "ManRN.phl[390]";
connectAttr "FKAnkle_R_rotateX.o" "ManRN.phl[391]";
connectAttr "FKAnkle_R_rotateY.o" "ManRN.phl[392]";
connectAttr "FKAnkle_R_rotateZ.o" "ManRN.phl[393]";
connectAttr "FKExtraToes_R_translateX.o" "ManRN.phl[394]";
connectAttr "FKExtraToes_R_translateY.o" "ManRN.phl[395]";
connectAttr "FKExtraToes_R_translateZ.o" "ManRN.phl[396]";
connectAttr "FKExtraToes_R_rotateX.o" "ManRN.phl[397]";
connectAttr "FKExtraToes_R_rotateY.o" "ManRN.phl[398]";
connectAttr "FKExtraToes_R_rotateZ.o" "ManRN.phl[399]";
connectAttr "FKToes_R_translateX.o" "ManRN.phl[400]";
connectAttr "FKToes_R_translateY.o" "ManRN.phl[401]";
connectAttr "FKToes_R_translateZ.o" "ManRN.phl[402]";
connectAttr "FKToes_R_rotateX.o" "ManRN.phl[403]";
connectAttr "FKToes_R_rotateY.o" "ManRN.phl[404]";
connectAttr "FKToes_R_rotateZ.o" "ManRN.phl[405]";
connectAttr "FKExtraHip_L_translateX.o" "ManRN.phl[406]";
connectAttr "FKExtraHip_L_translateY.o" "ManRN.phl[407]";
connectAttr "FKExtraHip_L_translateZ.o" "ManRN.phl[408]";
connectAttr "FKExtraHip_L_rotateX.o" "ManRN.phl[409]";
connectAttr "FKExtraHip_L_rotateY.o" "ManRN.phl[410]";
connectAttr "FKExtraHip_L_rotateZ.o" "ManRN.phl[411]";
connectAttr "FKHip_L_translateX.o" "ManRN.phl[412]";
connectAttr "FKHip_L_translateY.o" "ManRN.phl[413]";
connectAttr "FKHip_L_translateZ.o" "ManRN.phl[414]";
connectAttr "FKHip_L_rotateX.o" "ManRN.phl[415]";
connectAttr "FKHip_L_rotateY.o" "ManRN.phl[416]";
connectAttr "FKHip_L_rotateZ.o" "ManRN.phl[417]";
connectAttr "FKExtraKnee_L_translateX.o" "ManRN.phl[418]";
connectAttr "FKExtraKnee_L_translateY.o" "ManRN.phl[419]";
connectAttr "FKExtraKnee_L_translateZ.o" "ManRN.phl[420]";
connectAttr "FKExtraKnee_L_rotateX.o" "ManRN.phl[421]";
connectAttr "FKExtraKnee_L_rotateY.o" "ManRN.phl[422]";
connectAttr "FKExtraKnee_L_rotateZ.o" "ManRN.phl[423]";
connectAttr "FKKnee_L_translateX.o" "ManRN.phl[424]";
connectAttr "FKKnee_L_translateY.o" "ManRN.phl[425]";
connectAttr "FKKnee_L_translateZ.o" "ManRN.phl[426]";
connectAttr "FKKnee_L_rotateX.o" "ManRN.phl[427]";
connectAttr "FKKnee_L_rotateY.o" "ManRN.phl[428]";
connectAttr "FKKnee_L_rotateZ.o" "ManRN.phl[429]";
connectAttr "FKExtraAnkle_L_translateX.o" "ManRN.phl[430]";
connectAttr "FKExtraAnkle_L_translateY.o" "ManRN.phl[431]";
connectAttr "FKExtraAnkle_L_translateZ.o" "ManRN.phl[432]";
connectAttr "FKExtraAnkle_L_rotateX.o" "ManRN.phl[433]";
connectAttr "FKExtraAnkle_L_rotateY.o" "ManRN.phl[434]";
connectAttr "FKExtraAnkle_L_rotateZ.o" "ManRN.phl[435]";
connectAttr "FKAnkle_L_translateX.o" "ManRN.phl[436]";
connectAttr "FKAnkle_L_translateY.o" "ManRN.phl[437]";
connectAttr "FKAnkle_L_translateZ.o" "ManRN.phl[438]";
connectAttr "FKAnkle_L_rotateX.o" "ManRN.phl[439]";
connectAttr "FKAnkle_L_rotateY.o" "ManRN.phl[440]";
connectAttr "FKAnkle_L_rotateZ.o" "ManRN.phl[441]";
connectAttr "FKExtraToes_L_translateX.o" "ManRN.phl[442]";
connectAttr "FKExtraToes_L_translateY.o" "ManRN.phl[443]";
connectAttr "FKExtraToes_L_translateZ.o" "ManRN.phl[444]";
connectAttr "FKExtraToes_L_rotateX.o" "ManRN.phl[445]";
connectAttr "FKExtraToes_L_rotateY.o" "ManRN.phl[446]";
connectAttr "FKExtraToes_L_rotateZ.o" "ManRN.phl[447]";
connectAttr "FKToes_L_translateX.o" "ManRN.phl[448]";
connectAttr "FKToes_L_translateY.o" "ManRN.phl[449]";
connectAttr "FKToes_L_translateZ.o" "ManRN.phl[450]";
connectAttr "FKToes_L_rotateX.o" "ManRN.phl[451]";
connectAttr "FKToes_L_rotateY.o" "ManRN.phl[452]";
connectAttr "FKToes_L_rotateZ.o" "ManRN.phl[453]";
connectAttr "FKExtraMiddleFinger1_L_translateX.o" "ManRN.phl[454]";
connectAttr "FKExtraMiddleFinger1_L_translateY.o" "ManRN.phl[455]";
connectAttr "FKExtraMiddleFinger1_L_translateZ.o" "ManRN.phl[456]";
connectAttr "FKExtraMiddleFinger1_L_rotateX.o" "ManRN.phl[457]";
connectAttr "FKExtraMiddleFinger1_L_rotateY.o" "ManRN.phl[458]";
connectAttr "FKExtraMiddleFinger1_L_rotateZ.o" "ManRN.phl[459]";
connectAttr "FKMiddleFinger1_L_translateX.o" "ManRN.phl[460]";
connectAttr "FKMiddleFinger1_L_translateY.o" "ManRN.phl[461]";
connectAttr "FKMiddleFinger1_L_translateZ.o" "ManRN.phl[462]";
connectAttr "FKMiddleFinger1_L_rotateX.o" "ManRN.phl[463]";
connectAttr "FKMiddleFinger1_L_rotateY.o" "ManRN.phl[464]";
connectAttr "FKMiddleFinger1_L_rotateZ.o" "ManRN.phl[465]";
connectAttr "FKExtraMiddleFinger2_L_translateX.o" "ManRN.phl[466]";
connectAttr "FKExtraMiddleFinger2_L_translateY.o" "ManRN.phl[467]";
connectAttr "FKExtraMiddleFinger2_L_translateZ.o" "ManRN.phl[468]";
connectAttr "FKExtraMiddleFinger2_L_rotateX.o" "ManRN.phl[469]";
connectAttr "FKExtraMiddleFinger2_L_rotateY.o" "ManRN.phl[470]";
connectAttr "FKExtraMiddleFinger2_L_rotateZ.o" "ManRN.phl[471]";
connectAttr "FKMiddleFinger2_L_translateX.o" "ManRN.phl[472]";
connectAttr "FKMiddleFinger2_L_translateY.o" "ManRN.phl[473]";
connectAttr "FKMiddleFinger2_L_translateZ.o" "ManRN.phl[474]";
connectAttr "FKMiddleFinger2_L_rotateX.o" "ManRN.phl[475]";
connectAttr "FKMiddleFinger2_L_rotateY.o" "ManRN.phl[476]";
connectAttr "FKMiddleFinger2_L_rotateZ.o" "ManRN.phl[477]";
connectAttr "FKExtraMiddleFinger3_L_translateX.o" "ManRN.phl[478]";
connectAttr "FKExtraMiddleFinger3_L_translateY.o" "ManRN.phl[479]";
connectAttr "FKExtraMiddleFinger3_L_translateZ.o" "ManRN.phl[480]";
connectAttr "FKExtraMiddleFinger3_L_rotateX.o" "ManRN.phl[481]";
connectAttr "FKExtraMiddleFinger3_L_rotateY.o" "ManRN.phl[482]";
connectAttr "FKExtraMiddleFinger3_L_rotateZ.o" "ManRN.phl[483]";
connectAttr "FKMiddleFinger3_L_translateX.o" "ManRN.phl[484]";
connectAttr "FKMiddleFinger3_L_translateY.o" "ManRN.phl[485]";
connectAttr "FKMiddleFinger3_L_translateZ.o" "ManRN.phl[486]";
connectAttr "FKMiddleFinger3_L_rotateX.o" "ManRN.phl[487]";
connectAttr "FKMiddleFinger3_L_rotateY.o" "ManRN.phl[488]";
connectAttr "FKMiddleFinger3_L_rotateZ.o" "ManRN.phl[489]";
connectAttr "FKExtraThumbFinger1_L_translateX.o" "ManRN.phl[490]";
connectAttr "FKExtraThumbFinger1_L_translateY.o" "ManRN.phl[491]";
connectAttr "FKExtraThumbFinger1_L_translateZ.o" "ManRN.phl[492]";
connectAttr "FKExtraThumbFinger1_L_rotateX.o" "ManRN.phl[493]";
connectAttr "FKExtraThumbFinger1_L_rotateY.o" "ManRN.phl[494]";
connectAttr "FKExtraThumbFinger1_L_rotateZ.o" "ManRN.phl[495]";
connectAttr "FKThumbFinger1_L_translateX.o" "ManRN.phl[496]";
connectAttr "FKThumbFinger1_L_translateY.o" "ManRN.phl[497]";
connectAttr "FKThumbFinger1_L_translateZ.o" "ManRN.phl[498]";
connectAttr "FKThumbFinger1_L_rotateX.o" "ManRN.phl[499]";
connectAttr "FKThumbFinger1_L_rotateY.o" "ManRN.phl[500]";
connectAttr "FKThumbFinger1_L_rotateZ.o" "ManRN.phl[501]";
connectAttr "FKExtraThumbFinger2_L_translateX.o" "ManRN.phl[502]";
connectAttr "FKExtraThumbFinger2_L_translateY.o" "ManRN.phl[503]";
connectAttr "FKExtraThumbFinger2_L_translateZ.o" "ManRN.phl[504]";
connectAttr "FKExtraThumbFinger2_L_rotateX.o" "ManRN.phl[505]";
connectAttr "FKExtraThumbFinger2_L_rotateY.o" "ManRN.phl[506]";
connectAttr "FKExtraThumbFinger2_L_rotateZ.o" "ManRN.phl[507]";
connectAttr "FKThumbFinger2_L_translateX.o" "ManRN.phl[508]";
connectAttr "FKThumbFinger2_L_translateY.o" "ManRN.phl[509]";
connectAttr "FKThumbFinger2_L_translateZ.o" "ManRN.phl[510]";
connectAttr "FKThumbFinger2_L_rotateX.o" "ManRN.phl[511]";
connectAttr "FKThumbFinger2_L_rotateY.o" "ManRN.phl[512]";
connectAttr "FKThumbFinger2_L_rotateZ.o" "ManRN.phl[513]";
connectAttr "FKExtraThumbFinger3_L_translateX.o" "ManRN.phl[514]";
connectAttr "FKExtraThumbFinger3_L_translateY.o" "ManRN.phl[515]";
connectAttr "FKExtraThumbFinger3_L_translateZ.o" "ManRN.phl[516]";
connectAttr "FKExtraThumbFinger3_L_rotateX.o" "ManRN.phl[517]";
connectAttr "FKExtraThumbFinger3_L_rotateY.o" "ManRN.phl[518]";
connectAttr "FKExtraThumbFinger3_L_rotateZ.o" "ManRN.phl[519]";
connectAttr "FKThumbFinger3_L_translateX.o" "ManRN.phl[520]";
connectAttr "FKThumbFinger3_L_translateY.o" "ManRN.phl[521]";
connectAttr "FKThumbFinger3_L_translateZ.o" "ManRN.phl[522]";
connectAttr "FKThumbFinger3_L_rotateX.o" "ManRN.phl[523]";
connectAttr "FKThumbFinger3_L_rotateY.o" "ManRN.phl[524]";
connectAttr "FKThumbFinger3_L_rotateZ.o" "ManRN.phl[525]";
connectAttr "FKExtraIndexFinger1_L_translateX.o" "ManRN.phl[526]";
connectAttr "FKExtraIndexFinger1_L_translateY.o" "ManRN.phl[527]";
connectAttr "FKExtraIndexFinger1_L_translateZ.o" "ManRN.phl[528]";
connectAttr "FKExtraIndexFinger1_L_rotateX.o" "ManRN.phl[529]";
connectAttr "FKExtraIndexFinger1_L_rotateY.o" "ManRN.phl[530]";
connectAttr "FKExtraIndexFinger1_L_rotateZ.o" "ManRN.phl[531]";
connectAttr "FKIndexFinger1_L_translateX.o" "ManRN.phl[532]";
connectAttr "FKIndexFinger1_L_translateY.o" "ManRN.phl[533]";
connectAttr "FKIndexFinger1_L_translateZ.o" "ManRN.phl[534]";
connectAttr "FKIndexFinger1_L_rotateX.o" "ManRN.phl[535]";
connectAttr "FKIndexFinger1_L_rotateY.o" "ManRN.phl[536]";
connectAttr "FKIndexFinger1_L_rotateZ.o" "ManRN.phl[537]";
connectAttr "FKExtraIndexFinger2_L_translateX.o" "ManRN.phl[538]";
connectAttr "FKExtraIndexFinger2_L_translateY.o" "ManRN.phl[539]";
connectAttr "FKExtraIndexFinger2_L_translateZ.o" "ManRN.phl[540]";
connectAttr "FKExtraIndexFinger2_L_rotateX.o" "ManRN.phl[541]";
connectAttr "FKExtraIndexFinger2_L_rotateY.o" "ManRN.phl[542]";
connectAttr "FKExtraIndexFinger2_L_rotateZ.o" "ManRN.phl[543]";
connectAttr "FKIndexFinger2_L_translateX.o" "ManRN.phl[544]";
connectAttr "FKIndexFinger2_L_translateY.o" "ManRN.phl[545]";
connectAttr "FKIndexFinger2_L_translateZ.o" "ManRN.phl[546]";
connectAttr "FKIndexFinger2_L_rotateX.o" "ManRN.phl[547]";
connectAttr "FKIndexFinger2_L_rotateY.o" "ManRN.phl[548]";
connectAttr "FKIndexFinger2_L_rotateZ.o" "ManRN.phl[549]";
connectAttr "FKExtraIndexFinger3_L_translateX.o" "ManRN.phl[550]";
connectAttr "FKExtraIndexFinger3_L_translateY.o" "ManRN.phl[551]";
connectAttr "FKExtraIndexFinger3_L_translateZ.o" "ManRN.phl[552]";
connectAttr "FKExtraIndexFinger3_L_rotateX.o" "ManRN.phl[553]";
connectAttr "FKExtraIndexFinger3_L_rotateY.o" "ManRN.phl[554]";
connectAttr "FKExtraIndexFinger3_L_rotateZ.o" "ManRN.phl[555]";
connectAttr "FKIndexFinger3_L_translateX.o" "ManRN.phl[556]";
connectAttr "FKIndexFinger3_L_translateY.o" "ManRN.phl[557]";
connectAttr "FKIndexFinger3_L_translateZ.o" "ManRN.phl[558]";
connectAttr "FKIndexFinger3_L_rotateX.o" "ManRN.phl[559]";
connectAttr "FKIndexFinger3_L_rotateY.o" "ManRN.phl[560]";
connectAttr "FKIndexFinger3_L_rotateZ.o" "ManRN.phl[561]";
connectAttr "FKExtraRingFinger1_L_translateX.o" "ManRN.phl[562]";
connectAttr "FKExtraRingFinger1_L_translateY.o" "ManRN.phl[563]";
connectAttr "FKExtraRingFinger1_L_translateZ.o" "ManRN.phl[564]";
connectAttr "FKExtraRingFinger1_L_rotateX.o" "ManRN.phl[565]";
connectAttr "FKExtraRingFinger1_L_rotateY.o" "ManRN.phl[566]";
connectAttr "FKExtraRingFinger1_L_rotateZ.o" "ManRN.phl[567]";
connectAttr "FKRingFinger1_L_translateX.o" "ManRN.phl[568]";
connectAttr "FKRingFinger1_L_translateY.o" "ManRN.phl[569]";
connectAttr "FKRingFinger1_L_translateZ.o" "ManRN.phl[570]";
connectAttr "FKRingFinger1_L_rotateX.o" "ManRN.phl[571]";
connectAttr "FKRingFinger1_L_rotateY.o" "ManRN.phl[572]";
connectAttr "FKRingFinger1_L_rotateZ.o" "ManRN.phl[573]";
connectAttr "FKExtraRingFinger2_L_translateX.o" "ManRN.phl[574]";
connectAttr "FKExtraRingFinger2_L_translateY.o" "ManRN.phl[575]";
connectAttr "FKExtraRingFinger2_L_translateZ.o" "ManRN.phl[576]";
connectAttr "FKExtraRingFinger2_L_rotateX.o" "ManRN.phl[577]";
connectAttr "FKExtraRingFinger2_L_rotateY.o" "ManRN.phl[578]";
connectAttr "FKExtraRingFinger2_L_rotateZ.o" "ManRN.phl[579]";
connectAttr "FKRingFinger2_L_translateX.o" "ManRN.phl[580]";
connectAttr "FKRingFinger2_L_translateY.o" "ManRN.phl[581]";
connectAttr "FKRingFinger2_L_translateZ.o" "ManRN.phl[582]";
connectAttr "FKRingFinger2_L_rotateX.o" "ManRN.phl[583]";
connectAttr "FKRingFinger2_L_rotateY.o" "ManRN.phl[584]";
connectAttr "FKRingFinger2_L_rotateZ.o" "ManRN.phl[585]";
connectAttr "FKExtraRingFinger3_L_translateX.o" "ManRN.phl[586]";
connectAttr "FKExtraRingFinger3_L_translateY.o" "ManRN.phl[587]";
connectAttr "FKExtraRingFinger3_L_translateZ.o" "ManRN.phl[588]";
connectAttr "FKExtraRingFinger3_L_rotateX.o" "ManRN.phl[589]";
connectAttr "FKExtraRingFinger3_L_rotateY.o" "ManRN.phl[590]";
connectAttr "FKExtraRingFinger3_L_rotateZ.o" "ManRN.phl[591]";
connectAttr "FKRingFinger3_L_translateX.o" "ManRN.phl[592]";
connectAttr "FKRingFinger3_L_translateY.o" "ManRN.phl[593]";
connectAttr "FKRingFinger3_L_translateZ.o" "ManRN.phl[594]";
connectAttr "FKRingFinger3_L_rotateX.o" "ManRN.phl[595]";
connectAttr "FKRingFinger3_L_rotateY.o" "ManRN.phl[596]";
connectAttr "FKRingFinger3_L_rotateZ.o" "ManRN.phl[597]";
connectAttr "FKExtraPinkyFinger1_L_translateX.o" "ManRN.phl[598]";
connectAttr "FKExtraPinkyFinger1_L_translateY.o" "ManRN.phl[599]";
connectAttr "FKExtraPinkyFinger1_L_translateZ.o" "ManRN.phl[600]";
connectAttr "FKExtraPinkyFinger1_L_rotateX.o" "ManRN.phl[601]";
connectAttr "FKExtraPinkyFinger1_L_rotateY.o" "ManRN.phl[602]";
connectAttr "FKExtraPinkyFinger1_L_rotateZ.o" "ManRN.phl[603]";
connectAttr "FKPinkyFinger1_L_translateX.o" "ManRN.phl[604]";
connectAttr "FKPinkyFinger1_L_translateY.o" "ManRN.phl[605]";
connectAttr "FKPinkyFinger1_L_translateZ.o" "ManRN.phl[606]";
connectAttr "FKPinkyFinger1_L_rotateX.o" "ManRN.phl[607]";
connectAttr "FKPinkyFinger1_L_rotateY.o" "ManRN.phl[608]";
connectAttr "FKPinkyFinger1_L_rotateZ.o" "ManRN.phl[609]";
connectAttr "FKExtraPinkyFinger2_L_translateX.o" "ManRN.phl[610]";
connectAttr "FKExtraPinkyFinger2_L_translateY.o" "ManRN.phl[611]";
connectAttr "FKExtraPinkyFinger2_L_translateZ.o" "ManRN.phl[612]";
connectAttr "FKExtraPinkyFinger2_L_rotateX.o" "ManRN.phl[613]";
connectAttr "FKExtraPinkyFinger2_L_rotateY.o" "ManRN.phl[614]";
connectAttr "FKExtraPinkyFinger2_L_rotateZ.o" "ManRN.phl[615]";
connectAttr "FKPinkyFinger2_L_translateX.o" "ManRN.phl[616]";
connectAttr "FKPinkyFinger2_L_translateY.o" "ManRN.phl[617]";
connectAttr "FKPinkyFinger2_L_translateZ.o" "ManRN.phl[618]";
connectAttr "FKPinkyFinger2_L_rotateX.o" "ManRN.phl[619]";
connectAttr "FKPinkyFinger2_L_rotateY.o" "ManRN.phl[620]";
connectAttr "FKPinkyFinger2_L_rotateZ.o" "ManRN.phl[621]";
connectAttr "FKExtraPinkyFinger3_L_translateX.o" "ManRN.phl[622]";
connectAttr "FKExtraPinkyFinger3_L_translateY.o" "ManRN.phl[623]";
connectAttr "FKExtraPinkyFinger3_L_translateZ.o" "ManRN.phl[624]";
connectAttr "FKExtraPinkyFinger3_L_rotateX.o" "ManRN.phl[625]";
connectAttr "FKExtraPinkyFinger3_L_rotateY.o" "ManRN.phl[626]";
connectAttr "FKExtraPinkyFinger3_L_rotateZ.o" "ManRN.phl[627]";
connectAttr "FKPinkyFinger3_L_translateX.o" "ManRN.phl[628]";
connectAttr "FKPinkyFinger3_L_translateY.o" "ManRN.phl[629]";
connectAttr "FKPinkyFinger3_L_translateZ.o" "ManRN.phl[630]";
connectAttr "FKPinkyFinger3_L_rotateX.o" "ManRN.phl[631]";
connectAttr "FKPinkyFinger3_L_rotateY.o" "ManRN.phl[632]";
connectAttr "FKPinkyFinger3_L_rotateZ.o" "ManRN.phl[633]";
connectAttr "FKExtraShoulder_L_translateX.o" "ManRN.phl[634]";
connectAttr "FKExtraShoulder_L_translateY.o" "ManRN.phl[635]";
connectAttr "FKExtraShoulder_L_translateZ.o" "ManRN.phl[636]";
connectAttr "FKExtraShoulder_L_rotateX.o" "ManRN.phl[637]";
connectAttr "FKExtraShoulder_L_rotateY.o" "ManRN.phl[638]";
connectAttr "FKExtraShoulder_L_rotateZ.o" "ManRN.phl[639]";
connectAttr "FKShoulder_L_translateX.o" "ManRN.phl[640]";
connectAttr "FKShoulder_L_translateY.o" "ManRN.phl[641]";
connectAttr "FKShoulder_L_translateZ.o" "ManRN.phl[642]";
connectAttr "FKShoulder_L_rotateX.o" "ManRN.phl[643]";
connectAttr "FKShoulder_L_rotateY.o" "ManRN.phl[644]";
connectAttr "FKShoulder_L_rotateZ.o" "ManRN.phl[645]";
connectAttr "FKExtraElbow_L_translateX.o" "ManRN.phl[646]";
connectAttr "FKExtraElbow_L_translateY.o" "ManRN.phl[647]";
connectAttr "FKExtraElbow_L_translateZ.o" "ManRN.phl[648]";
connectAttr "FKExtraElbow_L_rotateX.o" "ManRN.phl[649]";
connectAttr "FKExtraElbow_L_rotateY.o" "ManRN.phl[650]";
connectAttr "FKExtraElbow_L_rotateZ.o" "ManRN.phl[651]";
connectAttr "FKElbow_L_translateX.o" "ManRN.phl[652]";
connectAttr "FKElbow_L_translateY.o" "ManRN.phl[653]";
connectAttr "FKElbow_L_translateZ.o" "ManRN.phl[654]";
connectAttr "FKElbow_L_rotateX.o" "ManRN.phl[655]";
connectAttr "FKElbow_L_rotateY.o" "ManRN.phl[656]";
connectAttr "FKElbow_L_rotateZ.o" "ManRN.phl[657]";
connectAttr "FKExtraWrist_L_translateX.o" "ManRN.phl[658]";
connectAttr "FKExtraWrist_L_translateY.o" "ManRN.phl[659]";
connectAttr "FKExtraWrist_L_translateZ.o" "ManRN.phl[660]";
connectAttr "FKExtraWrist_L_rotateX.o" "ManRN.phl[661]";
connectAttr "FKExtraWrist_L_rotateY.o" "ManRN.phl[662]";
connectAttr "FKExtraWrist_L_rotateZ.o" "ManRN.phl[663]";
connectAttr "FKWrist_L_translateX.o" "ManRN.phl[664]";
connectAttr "FKWrist_L_translateY.o" "ManRN.phl[665]";
connectAttr "FKWrist_L_translateZ.o" "ManRN.phl[666]";
connectAttr "FKWrist_L_rotateX.o" "ManRN.phl[667]";
connectAttr "FKWrist_L_rotateY.o" "ManRN.phl[668]";
connectAttr "FKWrist_L_rotateZ.o" "ManRN.phl[669]";
connectAttr "IKExtraArm_R_translateX.o" "ManRN.phl[670]";
connectAttr "IKExtraArm_R_translateY.o" "ManRN.phl[671]";
connectAttr "IKExtraArm_R_translateZ.o" "ManRN.phl[672]";
connectAttr "IKExtraArm_R_rotateX.o" "ManRN.phl[673]";
connectAttr "IKExtraArm_R_rotateY.o" "ManRN.phl[674]";
connectAttr "IKExtraArm_R_rotateZ.o" "ManRN.phl[675]";
connectAttr "IKArm_R_translateX.o" "ManRN.phl[676]";
connectAttr "IKArm_R_translateY.o" "ManRN.phl[677]";
connectAttr "IKArm_R_translateZ.o" "ManRN.phl[678]";
connectAttr "IKArm_R_rotateY.o" "ManRN.phl[679]";
connectAttr "IKArm_R_rotateZ.o" "ManRN.phl[680]";
connectAttr "IKArm_R_rotateX.o" "ManRN.phl[681]";
connectAttr "IKExtraLeg_R_translateX.o" "ManRN.phl[682]";
connectAttr "IKExtraLeg_R_translateY.o" "ManRN.phl[683]";
connectAttr "IKExtraLeg_R_translateZ.o" "ManRN.phl[684]";
connectAttr "IKExtraLeg_R_rotateX.o" "ManRN.phl[685]";
connectAttr "IKExtraLeg_R_rotateY.o" "ManRN.phl[686]";
connectAttr "IKExtraLeg_R_rotateZ.o" "ManRN.phl[687]";
connectAttr "IKLeg_R_translateX.o" "ManRN.phl[688]";
connectAttr "IKLeg_R_translateY.o" "ManRN.phl[689]";
connectAttr "IKLeg_R_translateZ.o" "ManRN.phl[690]";
connectAttr "IKLeg_R_rotateY.o" "ManRN.phl[691]";
connectAttr "IKLeg_R_rotateZ.o" "ManRN.phl[692]";
connectAttr "IKLeg_R_rotateX.o" "ManRN.phl[693]";
connectAttr "RollExtraHeel_R_translateX.o" "ManRN.phl[694]";
connectAttr "RollExtraHeel_R_translateY.o" "ManRN.phl[695]";
connectAttr "RollExtraHeel_R_translateZ.o" "ManRN.phl[696]";
connectAttr "RollExtraHeel_R_rotateX.o" "ManRN.phl[697]";
connectAttr "RollExtraHeel_R_rotateY.o" "ManRN.phl[698]";
connectAttr "RollExtraHeel_R_rotateZ.o" "ManRN.phl[699]";
connectAttr "RollHeel_R_translateX.o" "ManRN.phl[700]";
connectAttr "RollHeel_R_translateY.o" "ManRN.phl[701]";
connectAttr "RollHeel_R_translateZ.o" "ManRN.phl[702]";
connectAttr "RollHeel_R_rotateX.o" "ManRN.phl[703]";
connectAttr "RollHeel_R_rotateY.o" "ManRN.phl[704]";
connectAttr "RollHeel_R_rotateZ.o" "ManRN.phl[705]";
connectAttr "RollExtraToesEnd_R_translateX.o" "ManRN.phl[706]";
connectAttr "RollExtraToesEnd_R_translateY.o" "ManRN.phl[707]";
connectAttr "RollExtraToesEnd_R_translateZ.o" "ManRN.phl[708]";
connectAttr "RollExtraToesEnd_R_rotateX.o" "ManRN.phl[709]";
connectAttr "RollExtraToesEnd_R_rotateY.o" "ManRN.phl[710]";
connectAttr "RollExtraToesEnd_R_rotateZ.o" "ManRN.phl[711]";
connectAttr "RollToesEnd_R_translateX.o" "ManRN.phl[712]";
connectAttr "RollToesEnd_R_translateY.o" "ManRN.phl[713]";
connectAttr "RollToesEnd_R_translateZ.o" "ManRN.phl[714]";
connectAttr "RollToesEnd_R_rotateX.o" "ManRN.phl[715]";
connectAttr "RollToesEnd_R_rotateY.o" "ManRN.phl[716]";
connectAttr "RollToesEnd_R_rotateZ.o" "ManRN.phl[717]";
connectAttr "RollExtraToes_R_translateX.o" "ManRN.phl[718]";
connectAttr "RollExtraToes_R_translateY.o" "ManRN.phl[719]";
connectAttr "RollExtraToes_R_translateZ.o" "ManRN.phl[720]";
connectAttr "RollExtraToes_R_rotateX.o" "ManRN.phl[721]";
connectAttr "RollExtraToes_R_rotateY.o" "ManRN.phl[722]";
connectAttr "RollExtraToes_R_rotateZ.o" "ManRN.phl[723]";
connectAttr "RollToes_R_translateX.o" "ManRN.phl[724]";
connectAttr "RollToes_R_translateY.o" "ManRN.phl[725]";
connectAttr "RollToes_R_translateZ.o" "ManRN.phl[726]";
connectAttr "RollToes_R_rotateX.o" "ManRN.phl[727]";
connectAttr "RollToes_R_rotateY.o" "ManRN.phl[728]";
connectAttr "RollToes_R_rotateZ.o" "ManRN.phl[729]";
connectAttr "IKExtraToes_R_translateX.o" "ManRN.phl[730]";
connectAttr "IKExtraToes_R_translateY.o" "ManRN.phl[731]";
connectAttr "IKExtraToes_R_translateZ.o" "ManRN.phl[732]";
connectAttr "IKExtraToes_R_rotateX.o" "ManRN.phl[733]";
connectAttr "IKExtraToes_R_rotateY.o" "ManRN.phl[734]";
connectAttr "IKExtraToes_R_rotateZ.o" "ManRN.phl[735]";
connectAttr "IKToes_R_translateX.o" "ManRN.phl[736]";
connectAttr "IKToes_R_translateY.o" "ManRN.phl[737]";
connectAttr "IKToes_R_translateZ.o" "ManRN.phl[738]";
connectAttr "IKToes_R_rotateX.o" "ManRN.phl[739]";
connectAttr "IKToes_R_rotateY.o" "ManRN.phl[740]";
connectAttr "IKToes_R_rotateZ.o" "ManRN.phl[741]";
connectAttr "IKExtraArm_L_translateX.o" "ManRN.phl[742]";
connectAttr "IKExtraArm_L_translateY.o" "ManRN.phl[743]";
connectAttr "IKExtraArm_L_translateZ.o" "ManRN.phl[744]";
connectAttr "IKExtraArm_L_rotateX.o" "ManRN.phl[745]";
connectAttr "IKExtraArm_L_rotateY.o" "ManRN.phl[746]";
connectAttr "IKExtraArm_L_rotateZ.o" "ManRN.phl[747]";
connectAttr "IKArm_L_translateX.o" "ManRN.phl[748]";
connectAttr "IKArm_L_translateY.o" "ManRN.phl[749]";
connectAttr "IKArm_L_translateZ.o" "ManRN.phl[750]";
connectAttr "IKArm_L_rotateY.o" "ManRN.phl[751]";
connectAttr "IKArm_L_rotateZ.o" "ManRN.phl[752]";
connectAttr "IKArm_L_rotateX.o" "ManRN.phl[753]";
connectAttr "IKExtraLeg_L_translateX.o" "ManRN.phl[754]";
connectAttr "IKExtraLeg_L_translateY.o" "ManRN.phl[755]";
connectAttr "IKExtraLeg_L_translateZ.o" "ManRN.phl[756]";
connectAttr "IKExtraLeg_L_rotateX.o" "ManRN.phl[757]";
connectAttr "IKExtraLeg_L_rotateY.o" "ManRN.phl[758]";
connectAttr "IKExtraLeg_L_rotateZ.o" "ManRN.phl[759]";
connectAttr "IKLeg_L_translateX.o" "ManRN.phl[760]";
connectAttr "IKLeg_L_translateY.o" "ManRN.phl[761]";
connectAttr "IKLeg_L_translateZ.o" "ManRN.phl[762]";
connectAttr "IKLeg_L_rotateX.o" "ManRN.phl[763]";
connectAttr "IKLeg_L_rotateY.o" "ManRN.phl[764]";
connectAttr "IKLeg_L_rotateZ.o" "ManRN.phl[765]";
connectAttr "RollExtraHeel_L_translateX.o" "ManRN.phl[766]";
connectAttr "RollExtraHeel_L_translateY.o" "ManRN.phl[767]";
connectAttr "RollExtraHeel_L_translateZ.o" "ManRN.phl[768]";
connectAttr "RollExtraHeel_L_rotateX.o" "ManRN.phl[769]";
connectAttr "RollExtraHeel_L_rotateY.o" "ManRN.phl[770]";
connectAttr "RollExtraHeel_L_rotateZ.o" "ManRN.phl[771]";
connectAttr "RollHeel_L_translateX.o" "ManRN.phl[772]";
connectAttr "RollHeel_L_translateY.o" "ManRN.phl[773]";
connectAttr "RollHeel_L_translateZ.o" "ManRN.phl[774]";
connectAttr "RollHeel_L_rotateX.o" "ManRN.phl[775]";
connectAttr "RollHeel_L_rotateY.o" "ManRN.phl[776]";
connectAttr "RollHeel_L_rotateZ.o" "ManRN.phl[777]";
connectAttr "RollExtraToesEnd_L_translateX.o" "ManRN.phl[778]";
connectAttr "RollExtraToesEnd_L_translateY.o" "ManRN.phl[779]";
connectAttr "RollExtraToesEnd_L_translateZ.o" "ManRN.phl[780]";
connectAttr "RollExtraToesEnd_L_rotateX.o" "ManRN.phl[781]";
connectAttr "RollExtraToesEnd_L_rotateY.o" "ManRN.phl[782]";
connectAttr "RollExtraToesEnd_L_rotateZ.o" "ManRN.phl[783]";
connectAttr "RollToesEnd_L_translateX.o" "ManRN.phl[784]";
connectAttr "RollToesEnd_L_translateY.o" "ManRN.phl[785]";
connectAttr "RollToesEnd_L_translateZ.o" "ManRN.phl[786]";
connectAttr "RollToesEnd_L_rotateX.o" "ManRN.phl[787]";
connectAttr "RollToesEnd_L_rotateY.o" "ManRN.phl[788]";
connectAttr "RollToesEnd_L_rotateZ.o" "ManRN.phl[789]";
connectAttr "RollExtraToes_L_translateX.o" "ManRN.phl[790]";
connectAttr "RollExtraToes_L_translateY.o" "ManRN.phl[791]";
connectAttr "RollExtraToes_L_translateZ.o" "ManRN.phl[792]";
connectAttr "RollExtraToes_L_rotateX.o" "ManRN.phl[793]";
connectAttr "RollExtraToes_L_rotateY.o" "ManRN.phl[794]";
connectAttr "RollExtraToes_L_rotateZ.o" "ManRN.phl[795]";
connectAttr "RollToes_L_translateX.o" "ManRN.phl[796]";
connectAttr "RollToes_L_translateY.o" "ManRN.phl[797]";
connectAttr "RollToes_L_translateZ.o" "ManRN.phl[798]";
connectAttr "RollToes_L_rotateX.o" "ManRN.phl[799]";
connectAttr "RollToes_L_rotateY.o" "ManRN.phl[800]";
connectAttr "RollToes_L_rotateZ.o" "ManRN.phl[801]";
connectAttr "IKExtraToes_L_translateX.o" "ManRN.phl[802]";
connectAttr "IKExtraToes_L_translateY.o" "ManRN.phl[803]";
connectAttr "IKExtraToes_L_translateZ.o" "ManRN.phl[804]";
connectAttr "IKExtraToes_L_rotateX.o" "ManRN.phl[805]";
connectAttr "IKExtraToes_L_rotateY.o" "ManRN.phl[806]";
connectAttr "IKExtraToes_L_rotateZ.o" "ManRN.phl[807]";
connectAttr "IKToes_L_translateX.o" "ManRN.phl[808]";
connectAttr "IKToes_L_translateY.o" "ManRN.phl[809]";
connectAttr "IKToes_L_translateZ.o" "ManRN.phl[810]";
connectAttr "IKToes_L_rotateX.o" "ManRN.phl[811]";
connectAttr "IKToes_L_rotateY.o" "ManRN.phl[812]";
connectAttr "IKToes_L_rotateZ.o" "ManRN.phl[813]";
connectAttr "PoleExtraArm_R_translateX.o" "ManRN.phl[814]";
connectAttr "PoleExtraArm_R_translateY.o" "ManRN.phl[815]";
connectAttr "PoleExtraArm_R_translateZ.o" "ManRN.phl[816]";
connectAttr "PoleExtraArm_R_rotateX.o" "ManRN.phl[817]";
connectAttr "PoleExtraArm_R_rotateY.o" "ManRN.phl[818]";
connectAttr "PoleExtraArm_R_rotateZ.o" "ManRN.phl[819]";
connectAttr "PoleArm_R_translateX.o" "ManRN.phl[820]";
connectAttr "PoleArm_R_translateY.o" "ManRN.phl[821]";
connectAttr "PoleArm_R_translateZ.o" "ManRN.phl[822]";
connectAttr "IKExtracvSpine1_M_translateX.o" "ManRN.phl[823]";
connectAttr "IKExtracvSpine1_M_translateY.o" "ManRN.phl[824]";
connectAttr "IKExtracvSpine1_M_translateZ.o" "ManRN.phl[825]";
connectAttr "IKExtracvSpine1_M_rotateX.o" "ManRN.phl[826]";
connectAttr "IKExtracvSpine1_M_rotateY.o" "ManRN.phl[827]";
connectAttr "IKExtracvSpine1_M_rotateZ.o" "ManRN.phl[828]";
connectAttr "IKcvSpine1_M_translateZ.o" "ManRN.phl[829]";
connectAttr "IKcvSpine1_M_translateX.o" "ManRN.phl[830]";
connectAttr "IKcvSpine1_M_translateY.o" "ManRN.phl[831]";
connectAttr "IKExtracvSpine2_M_translateX.o" "ManRN.phl[832]";
connectAttr "IKExtracvSpine2_M_translateY.o" "ManRN.phl[833]";
connectAttr "IKExtracvSpine2_M_translateZ.o" "ManRN.phl[834]";
connectAttr "IKExtracvSpine2_M_rotateX.o" "ManRN.phl[835]";
connectAttr "IKExtracvSpine2_M_rotateY.o" "ManRN.phl[836]";
connectAttr "IKExtracvSpine2_M_rotateZ.o" "ManRN.phl[837]";
connectAttr "IKcvSpine2_M_translateZ.o" "ManRN.phl[838]";
connectAttr "IKcvSpine2_M_translateX.o" "ManRN.phl[839]";
connectAttr "IKcvSpine2_M_translateY.o" "ManRN.phl[840]";
connectAttr "IKExtraSpine2_M_translateX.o" "ManRN.phl[841]";
connectAttr "IKExtraSpine2_M_translateY.o" "ManRN.phl[842]";
connectAttr "IKExtraSpine2_M_translateZ.o" "ManRN.phl[843]";
connectAttr "IKExtraSpine2_M_rotateX.o" "ManRN.phl[844]";
connectAttr "IKExtraSpine2_M_rotateY.o" "ManRN.phl[845]";
connectAttr "IKExtraSpine2_M_rotateZ.o" "ManRN.phl[846]";
connectAttr "IKSpine2_M_translateX.o" "ManRN.phl[847]";
connectAttr "IKSpine2_M_translateY.o" "ManRN.phl[848]";
connectAttr "IKSpine2_M_translateZ.o" "ManRN.phl[849]";
connectAttr "IKSpine2_M_rotateX.o" "ManRN.phl[850]";
connectAttr "IKSpine2_M_rotateY.o" "ManRN.phl[851]";
connectAttr "IKSpine2_M_rotateZ.o" "ManRN.phl[852]";
connectAttr "IKExtraSpine1_M_translateX.o" "ManRN.phl[853]";
connectAttr "IKExtraSpine1_M_translateY.o" "ManRN.phl[854]";
connectAttr "IKExtraSpine1_M_translateZ.o" "ManRN.phl[855]";
connectAttr "IKExtraSpine1_M_rotateX.o" "ManRN.phl[856]";
connectAttr "IKExtraSpine1_M_rotateY.o" "ManRN.phl[857]";
connectAttr "IKExtraSpine1_M_rotateZ.o" "ManRN.phl[858]";
connectAttr "IKSpine1_M_translateX.o" "ManRN.phl[859]";
connectAttr "IKSpine1_M_translateY.o" "ManRN.phl[860]";
connectAttr "IKSpine1_M_translateZ.o" "ManRN.phl[861]";
connectAttr "IKSpine1_M_rotateX.o" "ManRN.phl[862]";
connectAttr "IKSpine1_M_rotateY.o" "ManRN.phl[863]";
connectAttr "IKSpine1_M_rotateZ.o" "ManRN.phl[864]";
connectAttr "IKhybridExtraSpine1_M_translateX.o" "ManRN.phl[865]";
connectAttr "IKhybridExtraSpine1_M_translateY.o" "ManRN.phl[866]";
connectAttr "IKhybridExtraSpine1_M_translateZ.o" "ManRN.phl[867]";
connectAttr "IKhybridExtraSpine1_M_rotateX.o" "ManRN.phl[868]";
connectAttr "IKhybridExtraSpine1_M_rotateY.o" "ManRN.phl[869]";
connectAttr "IKhybridExtraSpine1_M_rotateZ.o" "ManRN.phl[870]";
connectAttr "IKhybridSpine1_M_translateX.o" "ManRN.phl[871]";
connectAttr "IKhybridSpine1_M_translateY.o" "ManRN.phl[872]";
connectAttr "IKhybridSpine1_M_translateZ.o" "ManRN.phl[873]";
connectAttr "IKhybridSpine1_M_rotateX.o" "ManRN.phl[874]";
connectAttr "IKhybridSpine1_M_rotateY.o" "ManRN.phl[875]";
connectAttr "IKhybridSpine1_M_rotateZ.o" "ManRN.phl[876]";
connectAttr "IKhybridExtraSpine2_M_translateX.o" "ManRN.phl[877]";
connectAttr "IKhybridExtraSpine2_M_translateY.o" "ManRN.phl[878]";
connectAttr "IKhybridExtraSpine2_M_translateZ.o" "ManRN.phl[879]";
connectAttr "IKhybridExtraSpine2_M_rotateX.o" "ManRN.phl[880]";
connectAttr "IKhybridExtraSpine2_M_rotateY.o" "ManRN.phl[881]";
connectAttr "IKhybridExtraSpine2_M_rotateZ.o" "ManRN.phl[882]";
connectAttr "IKhybridSpine2_M_translateX.o" "ManRN.phl[883]";
connectAttr "IKhybridSpine2_M_translateY.o" "ManRN.phl[884]";
connectAttr "IKhybridSpine2_M_translateZ.o" "ManRN.phl[885]";
connectAttr "IKhybridSpine2_M_rotateX.o" "ManRN.phl[886]";
connectAttr "IKhybridSpine2_M_rotateY.o" "ManRN.phl[887]";
connectAttr "IKhybridSpine2_M_rotateZ.o" "ManRN.phl[888]";
connectAttr "IKhybridExtraSpine3_M_translateX.o" "ManRN.phl[889]";
connectAttr "IKhybridExtraSpine3_M_translateY.o" "ManRN.phl[890]";
connectAttr "IKhybridExtraSpine3_M_translateZ.o" "ManRN.phl[891]";
connectAttr "IKhybridExtraSpine3_M_rotateX.o" "ManRN.phl[892]";
connectAttr "IKhybridExtraSpine3_M_rotateY.o" "ManRN.phl[893]";
connectAttr "IKhybridExtraSpine3_M_rotateZ.o" "ManRN.phl[894]";
connectAttr "IKhybridSpine3_M_translateX.o" "ManRN.phl[895]";
connectAttr "IKhybridSpine3_M_translateY.o" "ManRN.phl[896]";
connectAttr "IKhybridSpine3_M_translateZ.o" "ManRN.phl[897]";
connectAttr "IKhybridSpine3_M_rotateX.o" "ManRN.phl[898]";
connectAttr "IKhybridSpine3_M_rotateY.o" "ManRN.phl[899]";
connectAttr "IKhybridSpine3_M_rotateZ.o" "ManRN.phl[900]";
connectAttr "IKExtraSpine3_M_translateX.o" "ManRN.phl[901]";
connectAttr "IKExtraSpine3_M_translateY.o" "ManRN.phl[902]";
connectAttr "IKExtraSpine3_M_translateZ.o" "ManRN.phl[903]";
connectAttr "IKExtraSpine3_M_rotateX.o" "ManRN.phl[904]";
connectAttr "IKExtraSpine3_M_rotateY.o" "ManRN.phl[905]";
connectAttr "IKExtraSpine3_M_rotateZ.o" "ManRN.phl[906]";
connectAttr "IKSpine3_M_translateX.o" "ManRN.phl[907]";
connectAttr "IKSpine3_M_translateY.o" "ManRN.phl[908]";
connectAttr "IKSpine3_M_translateZ.o" "ManRN.phl[909]";
connectAttr "IKSpine3_M_rotateX.o" "ManRN.phl[910]";
connectAttr "IKSpine3_M_rotateY.o" "ManRN.phl[911]";
connectAttr "IKSpine3_M_rotateZ.o" "ManRN.phl[912]";
connectAttr "PoleExtraLeg_R_translateX.o" "ManRN.phl[913]";
connectAttr "PoleExtraLeg_R_translateY.o" "ManRN.phl[914]";
connectAttr "PoleExtraLeg_R_translateZ.o" "ManRN.phl[915]";
connectAttr "PoleExtraLeg_R_rotateX.o" "ManRN.phl[916]";
connectAttr "PoleExtraLeg_R_rotateY.o" "ManRN.phl[917]";
connectAttr "PoleExtraLeg_R_rotateZ.o" "ManRN.phl[918]";
connectAttr "PoleLeg_R_translateX.o" "ManRN.phl[919]";
connectAttr "PoleLeg_R_translateY.o" "ManRN.phl[920]";
connectAttr "PoleLeg_R_translateZ.o" "ManRN.phl[921]";
connectAttr "PoleExtraArm_L_translateX.o" "ManRN.phl[922]";
connectAttr "PoleExtraArm_L_translateY.o" "ManRN.phl[923]";
connectAttr "PoleExtraArm_L_translateZ.o" "ManRN.phl[924]";
connectAttr "PoleExtraArm_L_rotateX.o" "ManRN.phl[925]";
connectAttr "PoleExtraArm_L_rotateY.o" "ManRN.phl[926]";
connectAttr "PoleExtraArm_L_rotateZ.o" "ManRN.phl[927]";
connectAttr "PoleArm_L_translateX.o" "ManRN.phl[928]";
connectAttr "PoleArm_L_translateY.o" "ManRN.phl[929]";
connectAttr "PoleArm_L_translateZ.o" "ManRN.phl[930]";
connectAttr "PoleExtraLeg_L_translateX.o" "ManRN.phl[931]";
connectAttr "PoleExtraLeg_L_translateY.o" "ManRN.phl[932]";
connectAttr "PoleExtraLeg_L_translateZ.o" "ManRN.phl[933]";
connectAttr "PoleExtraLeg_L_rotateX.o" "ManRN.phl[934]";
connectAttr "PoleExtraLeg_L_rotateY.o" "ManRN.phl[935]";
connectAttr "PoleExtraLeg_L_rotateZ.o" "ManRN.phl[936]";
connectAttr "PoleLeg_L_translateX.o" "ManRN.phl[937]";
connectAttr "PoleLeg_L_translateY.o" "ManRN.phl[938]";
connectAttr "PoleLeg_L_translateZ.o" "ManRN.phl[939]";
connectAttr "FKIKArm_R_FKIKBlend.o" "ManRN.phl[940]";
connectAttr "FKIKLeg_R_FKIKBlend.o" "ManRN.phl[941]";
connectAttr "FKIKSpine_M_FKIKBlend.o" "ManRN.phl[942]";
connectAttr "FKIKArm_L_FKIKBlend.o" "ManRN.phl[943]";
connectAttr "FKIKLeg_L_FKIKBlend.o" "ManRN.phl[944]";
connectAttr "AimEye_M_translateX.o" "ManRN.phl[945]";
connectAttr "AimEye_M_translateY.o" "ManRN.phl[946]";
connectAttr "AimEye_M_translateZ.o" "ManRN.phl[947]";
connectAttr "AimEye_M_rotateX.o" "ManRN.phl[948]";
connectAttr "AimEye_M_rotateY.o" "ManRN.phl[949]";
connectAttr "AimEye_M_rotateZ.o" "ManRN.phl[950]";
connectAttr "AimEye_R_translateX.o" "ManRN.phl[951]";
connectAttr "AimEye_R_translateY.o" "ManRN.phl[952]";
connectAttr "AimEye_R_translateZ.o" "ManRN.phl[953]";
connectAttr "AimEye_L_translateX.o" "ManRN.phl[954]";
connectAttr "AimEye_L_translateY.o" "ManRN.phl[955]";
connectAttr "AimEye_L_translateZ.o" "ManRN.phl[956]";
connectAttr "RootExtraX_M_translateX.o" "ManRN.phl[957]";
connectAttr "RootExtraX_M_translateY.o" "ManRN.phl[958]";
connectAttr "RootExtraX_M_translateZ.o" "ManRN.phl[959]";
connectAttr "RootExtraX_M_rotateX.o" "ManRN.phl[960]";
connectAttr "RootExtraX_M_rotateY.o" "ManRN.phl[961]";
connectAttr "RootExtraX_M_rotateZ.o" "ManRN.phl[962]";
connectAttr "RootX_M_translateX.o" "ManRN.phl[963]";
connectAttr "RootX_M_translateY.o" "ManRN.phl[964]";
connectAttr "RootX_M_translateZ.o" "ManRN.phl[965]";
connectAttr "RootX_M_rotateX.o" "ManRN.phl[966]";
connectAttr "RootX_M_rotateY.o" "ManRN.phl[967]";
connectAttr "RootX_M_rotateZ.o" "ManRN.phl[968]";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of Scene.ma
