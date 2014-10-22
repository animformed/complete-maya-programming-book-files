//Maya ASCII 4.0 scene
//Name: GroundShadow.ma
//Last modified: Tue, Dec 25, 2001 12:45:56 PM
requires maya "4.0";
currentUnit -l centimeter -a degree -t film;
createNode transform -n "pCube1";
	setAttr ".t" -type "double3" -4.5285681444374735 3.4577342344254585 -1.687776901262791 ;
	setAttr ".r" -type "double3" -8.3135406985411731 -6.7142038314639834 0.97877781997702462 ;
	setAttr ".s" -type "double3" 1 1 3.3916794685496683 ;
createNode mesh -n "pCubeShape1" -p "pCube1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
createNode transform -n "pCube2";
	setAttr ".t" -type "double3" -4.407026120445007 1.5802073228437039 0 ;
	setAttr ".s" -type "double3" 1 3.1623575983798236 1.1530031218133592 ;
createNode mesh -n "pCubeShape2" -p "pCube2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
createNode transform -n "pCube3";
	setAttr ".t" -type "double3" -4.2660028682110838 1.4055826922018704 -2.7367568758556526 ;
	setAttr ".s" -type "double3" 1 2.7592115498390704 1.1530031218133592 ;
createNode mesh -n "pCubeShape3" -p "pCube3";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "group1";
	setAttr ".t" -type "double3" -3.9437802478701012 0.24750965576471562 3.1605823495650309 ;
	setAttr ".r" -type "double3" 0 81.393458771256135 0 ;
createNode transform -n "pCube4" -p "group1";
	setAttr ".t" -type "double3" -0.12154202399246568 3.2730620275925864 3.472973534274542 ;
	setAttr ".r" -type "double3" -8.3135406985411731 -6.7142038314639834 0.97877781997702462 ;
	setAttr ".s" -type "double3" 1 1 3.3916794685496683 ;
createNode mesh -n "pCubeShape4" -p "|group1|pCube4";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "pCube5" -p "group1";
	setAttr ".t" -type "double3" 8.1171974950508913e-016 1.3586006746442578 
		5.1607504355373326 ;
	setAttr ".s" -type "double3" 1 3.1623575983798236 1.1530031218133592 ;
createNode mesh -n "pCubeShape5" -p "|group1|pCube5";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "pCube6" -p "group1";
	setAttr ".t" -type "double3" 0.1410232522339239 1.1470416026358499 2.4239935596816804 ;
	setAttr ".s" -type "double3" 1 2.7592115498390704 1.1530031218133592 ;
createNode mesh -n "pCubeShape6" -p "|group1|pCube6";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "group2";
	setAttr ".t" -type "double3" 6.2879608418112767 0.048543045753946412 1.2421028397298222 ;
	setAttr ".r" -type "double3" 7.0195835743237771e-015 208.88323601778754 
		0 ;
createNode transform -n "pCube4" -p "group2";
	setAttr ".t" -type "double3" -0.12154202399246605 3.4577342344254585 3.4729735342745425 ;
	setAttr ".r" -type "double3" -8.3135406985411731 -6.7142038314639834 0.97877781997702462 ;
	setAttr ".s" -type "double3" 1 1 3.3916794685496683 ;
createNode mesh -n "pCubeShape4" -p "|group2|pCube4";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "pCube5" -p "group2";
	setAttr ".t" -type "double3" 0 1.5432728814771299 5.1607504355373335 ;
	setAttr ".s" -type "double3" 1 3.1623575983798236 1.1530031218133592 ;
createNode mesh -n "pCubeShape5" -p "|group2|pCube5";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "pCube6" -p "group2";
	setAttr ".t" -type "double3" 0.14102325223392354 1.331713809468722 2.4239935596816808 ;
	setAttr ".s" -type "double3" 1 2.7592115498390704 1.1530031218133592 ;
createNode mesh -n "pCubeShape6" -p "|group2|pCube6";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 14 ".uvst[0].uvsp[0:13]" -type "float2" 0 0 1 0 
		0 1 1 1 0 2 1 2 0 3 1 3 0 4 1 4 2 0 2 1 -1 0 -1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 8 ".vt[0:7]"  -0.5 -0.5 0.5 0.5 -0.5 0.5 -0.5 
		0.5 0.5 0.5 0.5 0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 -0.5 -0.5;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 
		0 4 5 0 6 7 0 0 2 0 1 
		3 0 2 4 0 3 5 0 4 6 0 
		5 7 0 6 0 0 7 1 0;
	setAttr -s 6 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5 
		mu 0 4 0 1 3 2 
		f 4 1 7 -3 -7 
		mu 0 4 2 3 5 4 
		f 4 2 9 -4 -9 
		mu 0 4 4 5 7 6 
		f 4 3 11 -1 -11 
		mu 0 4 6 7 9 8 
		f 4 -12 -10 -8 -6 
		mu 0 4 1 10 11 3 
		f 4 10 4 6 8 
		mu 0 4 12 0 2 13 ;
createNode transform -n "pCube7";
	setAttr ".t" -type "double3" -0.76878455625073494 0.51619860915535642 -5.0085628514270173 ;
	setAttr ".r" -type "double3" 0 -17.195749654112042 0 ;
	setAttr ".s" -type "double3" 2.9684034384454745 1 1 ;
createNode mesh -n "pCubeShape7" -p "pCube7";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
createNode transform -n "nurbsSphere2";
	setAttr ".t" -type "double3" 0.022322274719032809 2.9655912316734079 -0.33986184536148456 ;
createNode nurbsSurface -n "nurbsSphereShape2" -p "nurbsSphere2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "nurbsSphere1" -p "nurbsSphere2";
	setAttr ".t" -type "double3" 1.14342207902535 0.11320468524317562 0 ;
	setAttr ".rp" -type "double3" -1.1474659286974989 0 0 ;
	setAttr ".sp" -type "double3" -1.1474659286974989 0 0 ;
createNode nurbsSurface -n "nurbsSphereShape1" -p "nurbsSphere1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "nurbsSphere3" -p "nurbsSphere1";
	setAttr ".t" -type "double3" 0.86403725854296543 -0.013728573063072957 
		0 ;
	setAttr ".rp" -type "double3" -1.99512044813165 4.4408920985006262e-016 
		0 ;
	setAttr ".sp" -type "double3" -1.99512044813165 4.4408920985006262e-016 
		0 ;
createNode nurbsSurface -n "nurbsSphereShape3" -p "nurbsSphere3";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "camera1";
	setAttr ".t" -type "double3" -22.778186919264691 15.52627200458635 -24.876766393913528 ;
	setAttr ".r" -type "double3" -22.199216848339322 -135.88229690163277 0 ;
createNode camera -n "cameraShape1" -p "camera1";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".cap" -type "double2" 1.4173 0.9449 ;
	setAttr ".ff" 2;
	setAttr ".ncp" 0.01;
	setAttr ".coi" 34.744589215371505;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "camera1";
	setAttr ".den" -type "string" "camera1_depth";
	setAttr ".man" -type "string" "camera1_mask";
	setAttr ".tp" -type "double3" 0.3093138961651114 6.494982172745897 -0.59206557005920768 ;
createNode transform -n "pointLight1";
	setAttr ".t" -type "double3" -0.58000488323323118 11.955708541016543 0 ;
createNode pointLight -n "pointLightShape1" -p "pointLight1";
	setAttr -k off ".v";
createNode transform -n "side1";
	setAttr ".t" -type "double3" 100 1.7539302802460703 -1.4477101845522908 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -n "sideShape2" -p "side1";
	setAttr -k off ".v";
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 14.736842105263158;
	setAttr ".imn" -type "string" "side1";
	setAttr ".den" -type "string" "side1_depth";
	setAttr ".man" -type "string" "side1_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -4.7228827447146885e-014 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.821869662029947;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode lightLinker -n "lightLinker1";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
createNode renderLayer -s -n "globalRender";
createNode polyCube -n "polyCube1";
createNode polyCube -n "polyCube2";
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n"
		+ "//\n"
		+ "//  This script is machine generated.  Edit at your own risk.\n"
		+ "//\n"
		+ "//\n"
		+ "global string $gMainPane;\n"
		+ "if (`paneLayout -exists $gMainPane`) {\n"
		+ "	global int $gUseScenePanelConfig;\n"
		+ "	int    $useSceneConfig = $gUseScenePanelConfig;\n"
		+ "	int    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;	int    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n"
		+ "	int    $nPanes = 0;\n"
		+ "	string $editorName;\n"
		+ "	string $panelName;\n"
		+ "	string $itemFilterName;\n"
		+ "	string $panelConfig;\n"
		+ "	//\n"
		+ "	//  get current state of the UI\n"
		+ "	//\n"
		+ "	sceneUIReplacement -update $gMainPane;\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Top View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Top View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"top\" \n"
		+ "                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n"
		+ "                -displayAppearance \"wireframe\" \n"
		+ "                -activeOnly 0\n"
		+ "                -wireframeOnShaded 0\n"
		+ "                -bufferMode \"double\" \n"
		+ "                -twoSidedLighting 1\n"
		+ "                -backfaceCulling 0\n"
		+ "                -xray 0\n"
		+ "                -displayTextures 0\n"
		+ "                -textureAnisotropic 0\n"
		+ "                -textureHilight 1\n"
		+ "                -textureSampling 2\n"
		+ "                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 1024\n"
		+ "                -fogging 0\n"
		+ "                -fogSource \"fragment\" \n"
		+ "                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n"
		+ "                -fogEnd 100\n"
		+ "                -fogDensity 0.1\n"
		+ "                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n"
		+ "                -polymeshes 1\n"
		+ "                -subdivSurfaces 1\n"
		+ "                -planes 1\n"
		+ "                -lights 1\n"
		+ "                -cameras 1\n"
		+ "                -controlVertices 1\n"
		+ "                -hulls 1\n"
		+ "                -grid 1\n"
		+ "                -joints 1\n"
		+ "                -ikHandles 1\n"
		+ "                -deformers 1\n"
		+ "                -dynamics 1\n"
		+ "                -locators 1\n"
		+ "                -dimensions 1\n"
		+ "                -handles 1\n"
		+ "                -pivots 1\n"
		+ "                -textures 1\n"
		+ "                -strokes 1\n"
		+ "                -shadows 0\n"
		+ "                $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		modelPanel -edit -l \"Top View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"top\" \n"
		+ "            -useInteractiveMode 0\n"
		+ "            -displayLights \"default\" \n"
		+ "            -displayAppearance \"wireframe\" \n"
		+ "            -activeOnly 0\n"
		+ "            -wireframeOnShaded 0\n"
		+ "            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n"
		+ "            -backfaceCulling 0\n"
		+ "            -xray 0\n"
		+ "            -displayTextures 0\n"
		+ "            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n"
		+ "            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n"
		+ "            -textureMaxSize 1024\n"
		+ "            -fogging 0\n"
		+ "            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n"
		+ "            -fogStart 0\n"
		+ "            -fogEnd 100\n"
		+ "            -fogDensity 0.1\n"
		+ "            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -nurbsCurves 1\n"
		+ "            -nurbsSurfaces 1\n"
		+ "            -polymeshes 1\n"
		+ "            -subdivSurfaces 1\n"
		+ "            -planes 1\n"
		+ "            -lights 1\n"
		+ "            -cameras 1\n"
		+ "            -controlVertices 1\n"
		+ "            -hulls 1\n"
		+ "            -grid 1\n"
		+ "            -joints 1\n"
		+ "            -ikHandles 1\n"
		+ "            -deformers 1\n"
		+ "            -dynamics 1\n"
		+ "            -locators 1\n"
		+ "            -dimensions 1\n"
		+ "            -handles 1\n"
		+ "            -pivots 1\n"
		+ "            -textures 1\n"
		+ "            -strokes 1\n"
		+ "            -shadows 0\n"
		+ "            $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Side View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Side View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"side1\" \n"
		+ "                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n"
		+ "                -displayAppearance \"smoothShaded\" \n"
		+ "                -activeOnly 0\n"
		+ "                -wireframeOnShaded 0\n"
		+ "                -bufferMode \"double\" \n"
		+ "                -twoSidedLighting 1\n"
		+ "                -backfaceCulling 0\n"
		+ "                -xray 0\n"
		+ "                -displayTextures 0\n"
		+ "                -textureAnisotropic 0\n"
		+ "                -textureHilight 1\n"
		+ "                -textureSampling 2\n"
		+ "                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 1024\n"
		+ "                -fogging 0\n"
		+ "                -fogSource \"fragment\" \n"
		+ "                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n"
		+ "                -fogEnd 100\n"
		+ "                -fogDensity 0.1\n"
		+ "                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n"
		+ "                -polymeshes 1\n"
		+ "                -subdivSurfaces 1\n"
		+ "                -planes 1\n"
		+ "                -lights 1\n"
		+ "                -cameras 1\n"
		+ "                -controlVertices 1\n"
		+ "                -hulls 1\n"
		+ "                -grid 1\n"
		+ "                -joints 1\n"
		+ "                -ikHandles 1\n"
		+ "                -deformers 1\n"
		+ "                -dynamics 1\n"
		+ "                -locators 1\n"
		+ "                -dimensions 1\n"
		+ "                -handles 1\n"
		+ "                -pivots 1\n"
		+ "                -textures 1\n"
		+ "                -strokes 1\n"
		+ "                -shadows 0\n"
		+ "                $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		modelPanel -edit -l \"Side View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"side1\" \n"
		+ "            -useInteractiveMode 0\n"
		+ "            -displayLights \"default\" \n"
		+ "            -displayAppearance \"smoothShaded\" \n"
		+ "            -activeOnly 0\n"
		+ "            -wireframeOnShaded 0\n"
		+ "            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n"
		+ "            -backfaceCulling 0\n"
		+ "            -xray 0\n"
		+ "            -displayTextures 0\n"
		+ "            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n"
		+ "            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n"
		+ "            -textureMaxSize 1024\n"
		+ "            -fogging 0\n"
		+ "            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n"
		+ "            -fogStart 0\n"
		+ "            -fogEnd 100\n"
		+ "            -fogDensity 0.1\n"
		+ "            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -nurbsCurves 1\n"
		+ "            -nurbsSurfaces 1\n"
		+ "            -polymeshes 1\n"
		+ "            -subdivSurfaces 1\n"
		+ "            -planes 1\n"
		+ "            -lights 1\n"
		+ "            -cameras 1\n"
		+ "            -controlVertices 1\n"
		+ "            -hulls 1\n"
		+ "            -grid 1\n"
		+ "            -joints 1\n"
		+ "            -ikHandles 1\n"
		+ "            -deformers 1\n"
		+ "            -dynamics 1\n"
		+ "            -locators 1\n"
		+ "            -dimensions 1\n"
		+ "            -handles 1\n"
		+ "            -pivots 1\n"
		+ "            -textures 1\n"
		+ "            -strokes 1\n"
		+ "            -shadows 0\n"
		+ "            $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Front View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Front View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"front\" \n"
		+ "                -useInteractiveMode 0\n"
		+ "                -displayLights \"default\" \n"
		+ "                -displayAppearance \"smoothShaded\" \n"
		+ "                -activeOnly 0\n"
		+ "                -wireframeOnShaded 0\n"
		+ "                -bufferMode \"double\" \n"
		+ "                -twoSidedLighting 1\n"
		+ "                -backfaceCulling 0\n"
		+ "                -xray 0\n"
		+ "                -displayTextures 0\n"
		+ "                -textureAnisotropic 0\n"
		+ "                -textureHilight 1\n"
		+ "                -textureSampling 2\n"
		+ "                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 1024\n"
		+ "                -fogging 0\n"
		+ "                -fogSource \"fragment\" \n"
		+ "                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n"
		+ "                -fogEnd 100\n"
		+ "                -fogDensity 0.1\n"
		+ "                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n"
		+ "                -polymeshes 1\n"
		+ "                -subdivSurfaces 1\n"
		+ "                -planes 1\n"
		+ "                -lights 1\n"
		+ "                -cameras 1\n"
		+ "                -controlVertices 1\n"
		+ "                -hulls 1\n"
		+ "                -grid 1\n"
		+ "                -joints 1\n"
		+ "                -ikHandles 1\n"
		+ "                -deformers 1\n"
		+ "                -dynamics 1\n"
		+ "                -locators 1\n"
		+ "                -dimensions 1\n"
		+ "                -handles 1\n"
		+ "                -pivots 1\n"
		+ "                -textures 1\n"
		+ "                -strokes 1\n"
		+ "                -shadows 0\n"
		+ "                $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		modelPanel -edit -l \"Front View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"front\" \n"
		+ "            -useInteractiveMode 0\n"
		+ "            -displayLights \"default\" \n"
		+ "            -displayAppearance \"smoothShaded\" \n"
		+ "            -activeOnly 0\n"
		+ "            -wireframeOnShaded 0\n"
		+ "            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n"
		+ "            -backfaceCulling 0\n"
		+ "            -xray 0\n"
		+ "            -displayTextures 0\n"
		+ "            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n"
		+ "            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n"
		+ "            -textureMaxSize 1024\n"
		+ "            -fogging 0\n"
		+ "            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n"
		+ "            -fogStart 0\n"
		+ "            -fogEnd 100\n"
		+ "            -fogDensity 0.1\n"
		+ "            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -nurbsCurves 1\n"
		+ "            -nurbsSurfaces 1\n"
		+ "            -polymeshes 1\n"
		+ "            -subdivSurfaces 1\n"
		+ "            -planes 1\n"
		+ "            -lights 1\n"
		+ "            -cameras 1\n"
		+ "            -controlVertices 1\n"
		+ "            -hulls 1\n"
		+ "            -grid 1\n"
		+ "            -joints 1\n"
		+ "            -ikHandles 1\n"
		+ "            -deformers 1\n"
		+ "            -dynamics 1\n"
		+ "            -locators 1\n"
		+ "            -dimensions 1\n"
		+ "            -handles 1\n"
		+ "            -pivots 1\n"
		+ "            -textures 1\n"
		+ "            -strokes 1\n"
		+ "            -shadows 0\n"
		+ "            $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Persp View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Persp View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"camera1\" \n"
		+ "                -useInteractiveMode 0\n"
		+ "                -displayLights \"all\" \n"
		+ "                -displayAppearance \"smoothShaded\" \n"
		+ "                -activeOnly 0\n"
		+ "                -wireframeOnShaded 0\n"
		+ "                -bufferMode \"double\" \n"
		+ "                -twoSidedLighting 1\n"
		+ "                -backfaceCulling 0\n"
		+ "                -xray 0\n"
		+ "                -displayTextures 0\n"
		+ "                -textureAnisotropic 0\n"
		+ "                -textureHilight 1\n"
		+ "                -textureSampling 2\n"
		+ "                -textureDisplay \"modulate\" \n"
		+ "                -textureMaxSize 1024\n"
		+ "                -fogging 0\n"
		+ "                -fogSource \"fragment\" \n"
		+ "                -fogMode \"linear\" \n"
		+ "                -fogStart 0\n"
		+ "                -fogEnd 100\n"
		+ "                -fogDensity 0.1\n"
		+ "                -fogColor 0.5 0.5 0.5 1 \n"
		+ "                -nurbsCurves 1\n"
		+ "                -nurbsSurfaces 1\n"
		+ "                -polymeshes 1\n"
		+ "                -subdivSurfaces 1\n"
		+ "                -planes 1\n"
		+ "                -lights 1\n"
		+ "                -cameras 1\n"
		+ "                -controlVertices 1\n"
		+ "                -hulls 1\n"
		+ "                -grid 1\n"
		+ "                -joints 1\n"
		+ "                -ikHandles 1\n"
		+ "                -deformers 1\n"
		+ "                -dynamics 1\n"
		+ "                -locators 1\n"
		+ "                -dimensions 1\n"
		+ "                -handles 1\n"
		+ "                -pivots 1\n"
		+ "                -textures 1\n"
		+ "                -strokes 1\n"
		+ "                -shadows 0\n"
		+ "                $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		modelPanel -edit -l \"Persp View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"camera1\" \n"
		+ "            -useInteractiveMode 0\n"
		+ "            -displayLights \"all\" \n"
		+ "            -displayAppearance \"smoothShaded\" \n"
		+ "            -activeOnly 0\n"
		+ "            -wireframeOnShaded 0\n"
		+ "            -bufferMode \"double\" \n"
		+ "            -twoSidedLighting 1\n"
		+ "            -backfaceCulling 0\n"
		+ "            -xray 0\n"
		+ "            -displayTextures 0\n"
		+ "            -textureAnisotropic 0\n"
		+ "            -textureHilight 1\n"
		+ "            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n"
		+ "            -textureMaxSize 1024\n"
		+ "            -fogging 0\n"
		+ "            -fogSource \"fragment\" \n"
		+ "            -fogMode \"linear\" \n"
		+ "            -fogStart 0\n"
		+ "            -fogEnd 100\n"
		+ "            -fogDensity 0.1\n"
		+ "            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -nurbsCurves 1\n"
		+ "            -nurbsSurfaces 1\n"
		+ "            -polymeshes 1\n"
		+ "            -subdivSurfaces 1\n"
		+ "            -planes 1\n"
		+ "            -lights 1\n"
		+ "            -cameras 1\n"
		+ "            -controlVertices 1\n"
		+ "            -hulls 1\n"
		+ "            -grid 1\n"
		+ "            -joints 1\n"
		+ "            -ikHandles 1\n"
		+ "            -deformers 1\n"
		+ "            -dynamics 1\n"
		+ "            -locators 1\n"
		+ "            -dimensions 1\n"
		+ "            -handles 1\n"
		+ "            -pivots 1\n"
		+ "            -textures 1\n"
		+ "            -strokes 1\n"
		+ "            -shadows 0\n"
		+ "            $editorName;\n"
		+ "modelEditor -e -viewSelected 0 $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" \"Outliner\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `outlinerPanel -unParent -l \"Outliner\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            outlinerEditor -e \n"
		+ "                -mainListConnection \"worldList\" \n"
		+ "                -selectionConnection \"modelList\" \n"
		+ "                -showShapes 1\n"
		+ "                -showAttributes 0\n"
		+ "                -showConnected 0\n"
		+ "                -showAnimCurvesOnly 0\n"
		+ "                -autoExpand 0\n"
		+ "                -showDagOnly 1\n"
		+ "                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 0\n"
		+ "                -showUnitlessCurves 1\n"
		+ "                -showCompounds 1\n"
		+ "                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 0\n"
		+ "                -highlightActive 1\n"
		+ "                -autoSelectNewObjects 0\n"
		+ "                -doNotSelectNewObjects 0\n"
		+ "                -dropIsParent 1\n"
		+ "                -transmitFilters 0\n"
		+ "                -setFilter \"defaultSetFilter\" \n"
		+ "                -showSetMembers 1\n"
		+ "                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n"
		+ "                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n"
		+ "                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n"
		+ "                -sortOrder \"none\" \n"
		+ "                -longNames 0\n"
		+ "                -niceNames 1\n"
		+ "                $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		outlinerPanel -edit -l \"Outliner\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        outlinerEditor -e \n"
		+ "            -mainListConnection \"worldList\" \n"
		+ "            -selectionConnection \"modelList\" \n"
		+ "            -showShapes 1\n"
		+ "            -showAttributes 0\n"
		+ "            -showConnected 0\n"
		+ "            -showAnimCurvesOnly 0\n"
		+ "            -autoExpand 0\n"
		+ "            -showDagOnly 1\n"
		+ "            -ignoreDagHierarchy 0\n"
		+ "            -expandConnections 0\n"
		+ "            -showUnitlessCurves 1\n"
		+ "            -showCompounds 1\n"
		+ "            -showLeafs 1\n"
		+ "            -showNumericAttrsOnly 0\n"
		+ "            -highlightActive 1\n"
		+ "            -autoSelectNewObjects 0\n"
		+ "            -doNotSelectNewObjects 0\n"
		+ "            -dropIsParent 1\n"
		+ "            -transmitFilters 0\n"
		+ "            -setFilter \"defaultSetFilter\" \n"
		+ "            -showSetMembers 1\n"
		+ "            -allowMultiSelection 1\n"
		+ "            -alwaysToggleSelect 0\n"
		+ "            -directSelect 0\n"
		+ "            -displayMode \"DAG\" \n"
		+ "            -expandObjects 0\n"
		+ "            -setsIgnoreFilters 1\n"
		+ "            -editAttrName 0\n"
		+ "            -showAttrValues 0\n"
		+ "            -highlightSecondary 0\n"
		+ "            -showUVAttrsOnly 0\n"
		+ "            -showTextureNodesOnly 0\n"
		+ "            -sortOrder \"none\" \n"
		+ "            -longNames 0\n"
		+ "            -niceNames 1\n"
		+ "            $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	if ($useSceneConfig) {\n"
		+ "		outlinerPanel -e -to $panelName;\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" \"Graph Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l \"Graph Editor\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n"
		+ "                -mainListConnection \"graphEditorList\" \n"
		+ "                -selectionConnection \"graphEditor1FromOutliner\" \n"
		+ "                -highlightConnection \"keyframeList\" \n"
		+ "                -showShapes 1\n"
		+ "                -showAttributes 1\n"
		+ "                -showConnected 1\n"
		+ "                -showAnimCurvesOnly 1\n"
		+ "                -autoExpand 1\n"
		+ "                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 1\n"
		+ "                -showUnitlessCurves 1\n"
		+ "                -showCompounds 0\n"
		+ "                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n"
		+ "                -highlightActive 0\n"
		+ "                -autoSelectNewObjects 1\n"
		+ "                -doNotSelectNewObjects 0\n"
		+ "                -dropIsParent 1\n"
		+ "                -transmitFilters 1\n"
		+ "                -setFilter \"0\" \n"
		+ "                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n"
		+ "                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n"
		+ "                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n"
		+ "                -sortOrder \"none\" \n"
		+ "                -longNames 0\n"
		+ "                -niceNames 1\n"
		+ "                $editorName;\n"
		+ "			$editorName = ($panelName+\"GraphEd\");\n"
		+ "            animCurveEditor -e \n"
		+ "                -mainListConnection \"graphEditor1FromOutliner\" \n"
		+ "                -displayKeys 1\n"
		+ "                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 1\n"
		+ "                -displayInfinities 0\n"
		+ "                -autoFit 0\n"
		+ "                -snapTime \"none\" \n"
		+ "                -snapValue \"none\" \n"
		+ "                -showResults \"off\" \n"
		+ "                -showBufferCurves \"off\" \n"
		+ "                -smoothness \"fine\" \n"
		+ "                -resultSamples 1\n"
		+ "                -resultScreenSamples 0\n"
		+ "                -resultUpdate \"delayed\" \n"
		+ "                $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Graph Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "			$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n"
		+ "                -mainListConnection \"graphEditorList\" \n"
		+ "                -selectionConnection \"graphEditor1FromOutliner\" \n"
		+ "                -highlightConnection \"keyframeList\" \n"
		+ "                -showShapes 1\n"
		+ "                -showAttributes 1\n"
		+ "                -showConnected 1\n"
		+ "                -showAnimCurvesOnly 1\n"
		+ "                -autoExpand 1\n"
		+ "                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 1\n"
		+ "                -showUnitlessCurves 1\n"
		+ "                -showCompounds 0\n"
		+ "                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n"
		+ "                -highlightActive 0\n"
		+ "                -autoSelectNewObjects 1\n"
		+ "                -doNotSelectNewObjects 0\n"
		+ "                -dropIsParent 1\n"
		+ "                -transmitFilters 1\n"
		+ "                -setFilter \"0\" \n"
		+ "                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n"
		+ "                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n"
		+ "                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n"
		+ "                -sortOrder \"none\" \n"
		+ "                -longNames 0\n"
		+ "                -niceNames 1\n"
		+ "                $editorName;\n"
		+ "			$editorName = ($panelName+\"GraphEd\");\n"
		+ "            animCurveEditor -e \n"
		+ "                -mainListConnection \"graphEditor1FromOutliner\" \n"
		+ "                -displayKeys 1\n"
		+ "                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 1\n"
		+ "                -displayInfinities 0\n"
		+ "                -autoFit 0\n"
		+ "                -snapTime \"none\" \n"
		+ "                -snapValue \"none\" \n"
		+ "                -showResults \"off\" \n"
		+ "                -showBufferCurves \"off\" \n"
		+ "                -smoothness \"fine\" \n"
		+ "                -resultSamples 1\n"
		+ "                -resultScreenSamples 0\n"
		+ "                -resultUpdate \"delayed\" \n"
		+ "                $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" \"Dope Sheet\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l \"Dope Sheet\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n"
		+ "                -mainListConnection \"animationList\" \n"
		+ "                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n"
		+ "                -highlightConnection \"keyframeList\" \n"
		+ "                -showShapes 1\n"
		+ "                -showAttributes 1\n"
		+ "                -showConnected 1\n"
		+ "                -showAnimCurvesOnly 1\n"
		+ "                -autoExpand 0\n"
		+ "                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 1\n"
		+ "                -showUnitlessCurves 0\n"
		+ "                -showCompounds 1\n"
		+ "                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n"
		+ "                -highlightActive 0\n"
		+ "                -autoSelectNewObjects 0\n"
		+ "                -doNotSelectNewObjects 1\n"
		+ "                -dropIsParent 1\n"
		+ "                -transmitFilters 0\n"
		+ "                -setFilter \"0\" \n"
		+ "                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n"
		+ "                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n"
		+ "                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n"
		+ "                -sortOrder \"none\" \n"
		+ "                -longNames 0\n"
		+ "                -niceNames 1\n"
		+ "                $editorName;\n"
		+ "			$editorName = ($panelName+\"DopeSheetEd\");\n"
		+ "            dopeSheetEditor -e \n"
		+ "                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n"
		+ "                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n"
		+ "                -displayKeys 1\n"
		+ "                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 0\n"
		+ "                -displayInfinities 0\n"
		+ "                -autoFit 0\n"
		+ "                -snapTime \"integer\" \n"
		+ "                -snapValue \"none\" \n"
		+ "                -outliner \"dopeSheetPanel1OutlineEd\" \n"
		+ "                -showSummary 1\n"
		+ "                -showScene 0\n"
		+ "                -hierarchyBelow 0\n"
		+ "                $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Dope Sheet\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "			$editorName = ($panelName+\"OutlineEd\");\n"
		+ "            outlinerEditor -e \n"
		+ "                -mainListConnection \"animationList\" \n"
		+ "                -selectionConnection \"dopeSheetPanel1OutlinerSelection\" \n"
		+ "                -highlightConnection \"keyframeList\" \n"
		+ "                -showShapes 1\n"
		+ "                -showAttributes 1\n"
		+ "                -showConnected 1\n"
		+ "                -showAnimCurvesOnly 1\n"
		+ "                -autoExpand 0\n"
		+ "                -showDagOnly 0\n"
		+ "                -ignoreDagHierarchy 0\n"
		+ "                -expandConnections 1\n"
		+ "                -showUnitlessCurves 0\n"
		+ "                -showCompounds 1\n"
		+ "                -showLeafs 1\n"
		+ "                -showNumericAttrsOnly 1\n"
		+ "                -highlightActive 0\n"
		+ "                -autoSelectNewObjects 0\n"
		+ "                -doNotSelectNewObjects 1\n"
		+ "                -dropIsParent 1\n"
		+ "                -transmitFilters 0\n"
		+ "                -setFilter \"0\" \n"
		+ "                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n"
		+ "                -alwaysToggleSelect 0\n"
		+ "                -directSelect 0\n"
		+ "                -displayMode \"DAG\" \n"
		+ "                -expandObjects 0\n"
		+ "                -setsIgnoreFilters 1\n"
		+ "                -editAttrName 0\n"
		+ "                -showAttrValues 0\n"
		+ "                -highlightSecondary 0\n"
		+ "                -showUVAttrsOnly 0\n"
		+ "                -showTextureNodesOnly 0\n"
		+ "                -sortOrder \"none\" \n"
		+ "                -longNames 0\n"
		+ "                -niceNames 1\n"
		+ "                $editorName;\n"
		+ "			$editorName = ($panelName+\"DopeSheetEd\");\n"
		+ "            dopeSheetEditor -e \n"
		+ "                -mainListConnection \"dopeSheetPanel1FromOutliner\" \n"
		+ "                -highlightConnection \"dopeSheetPanel1OutlinerSelection\" \n"
		+ "                -displayKeys 1\n"
		+ "                -displayTangents 0\n"
		+ "                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 0\n"
		+ "                -displayInfinities 0\n"
		+ "                -autoFit 0\n"
		+ "                -snapTime \"integer\" \n"
		+ "                -snapValue \"none\" \n"
		+ "                -outliner \"dopeSheetPanel1OutlineEd\" \n"
		+ "                -showSummary 1\n"
		+ "                -showScene 0\n"
		+ "                -hierarchyBelow 0\n"
		+ "                $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" \"Trax Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l \"Trax Editor\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = ($panelName+\"ClipEditor\");\n"
		+ "            clipEditor -e \n"
		+ "                -characterOutline \"clipEditorPanel1OutlineEditor\" \n"
		+ "                -menuContext \"track\" \n"
		+ "                $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Trax Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "			$editorName = ($panelName+\"ClipEditor\");\n"
		+ "            clipEditor -e \n"
		+ "                -characterOutline \"clipEditorPanel1OutlineEditor\" \n"
		+ "                -menuContext \"track\" \n"
		+ "                $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" \"Hypergraph\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l \"Hypergraph\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = ($panelName+\"HyperGraphEd\");\n"
		+ "            hyperGraph -e \n"
		+ "                -orientation \"horiz\" \n"
		+ "                -zoom 1\n"
		+ "                -animateTransition 0\n"
		+ "                -showShapes 0\n"
		+ "                -showDeformers 0\n"
		+ "                -showExpressions 0\n"
		+ "                -showConstraints 0\n"
		+ "                -showUnderworld 0\n"
		+ "                -showInvisible 0\n"
		+ "                -transitionFrames 1\n"
		+ "                -freeform 0\n"
		+ "                -imageEnabled 0\n"
		+ "                -graphType \"DAG\" \n"
		+ "                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n"
		+ "                $editorName;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Hypergraph\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "			$editorName = ($panelName+\"HyperGraphEd\");\n"
		+ "            hyperGraph -e \n"
		+ "                -orientation \"horiz\" \n"
		+ "                -zoom 1\n"
		+ "                -animateTransition 0\n"
		+ "                -showShapes 0\n"
		+ "                -showDeformers 0\n"
		+ "                -showExpressions 0\n"
		+ "                -showConstraints 0\n"
		+ "                -showUnderworld 0\n"
		+ "                -showInvisible 0\n"
		+ "                -transitionFrames 1\n"
		+ "                -freeform 0\n"
		+ "                -imageEnabled 0\n"
		+ "                -graphType \"DAG\" \n"
		+ "                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n"
		+ "                $editorName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" \"Hypershade\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l \"Hypershade\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Hypershade\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" \"Visor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l \"Visor\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Visor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" \"UV Texture Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l \"UV Texture Editor\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"UV Texture Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"multiListerPanel\" \"Multilister\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"multiListerPanel\" -l \"Multilister\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Multilister\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" \"Render View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l \"Render View\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Render View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" \"Blend Shape\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			blendShapePanel -unParent -l \"Blend Shape\" -mbv $menusOkayInPanels ;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		blendShapePanel -edit -l \"Blend Shape\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" \"Dynamic Relationships\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l \"Dynamic Relationships\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Dynamic Relationships\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"devicePanel\" \"Devices\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			devicePanel -unParent -l \"Devices\" -mbv $menusOkayInPanels ;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		devicePanel -edit -l \"Devices\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" \"Relationship Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l \"Relationship Editor\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Relationship Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" \"Reference Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l \"Reference Editor\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Reference Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" \"Component Editor\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l \"Component Editor\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Component Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" \"Paint Effects\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l \"Paint Effects\" -mbv $menusOkayInPanels `;\n"
		+ "		}\n"
		+ "	} else {\n"
		+ "		$label = `panel -q -label $panelName`;\n"
		+ "		scriptedPanel -edit -l \"Paint Effects\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		if (!$useSceneConfig) {\n"
		+ "			panel -e -l $label $panelName;\n"
		+ "		}\n"
		+ "	}\n"
		+ "	if ($useSceneConfig) {\n"
		+ "        string $configName = `getPanel -cwl \"Current Layout\"`;\n"
		+ "        if (\"\" != $configName) {\n"
		+ "			panelConfiguration -edit -label \"Current Layout\"\n"
		+ "				-defaultImage \"\"\n"
		+ "				-image \"\"\n"
		+ "				-sc false\n"
		+ "				-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n"
		+ "				-removeAllPanels\n"
		+ "				-ap true\n"
		+ "					\"Persp View\"\n"
		+ "					\"modelPanel\"\n"
		+ "					\"$panelName = `modelPanel -unParent -l \\\"Persp View\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"camera1\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"all\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "					\"modelPanel -edit -l \\\"Persp View\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -camera \\\"camera1\\\" \\n    -useInteractiveMode 0\\n    -displayLights \\\"all\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "				$configName;\n"
		+ "            setNamedPanelLayout \"Current Layout\";\n"
		+ "        }\n"
		+ "        panelHistory -e -clear mainPanelHistory;\n"
		+ "        setFocus `paneLayout -q -p1 $gMainPane`;\n"
		+ "        sceneUIReplacement -deleteRemaining;\n"
		+ "        sceneUIReplacement -clear;\n"
		+ "	}\n"
		+ "grid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold no -perspectiveLabelPosition axis -orthographicLabelPosition edge;\n"
		+ "}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 48 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode makeNurbSphere -n "makeNurbSphere1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 0.3;
createNode polyCube -n "polyCube3";
createNode makeNurbSphere -n "makeNurbSphere2";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 0.5;
createNode makeNurbSphere -n "makeNurbSphere3";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 0.20000000000000001;
createNode lambert -n "lambert2";
	setAttr ".c" -type "float3" 0.23976 0.31011131 0.37 ;
createNode shadingEngine -n "lambert2SG";
	setAttr ".ihi" 0;
	setAttr -s 10 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode lambert -n "lambert3";
	setAttr ".c" -type "float3" 1 0.22116667 0 ;
createNode shadingEngine -n "lambert3SG";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode animCurveTA -n "nurbsSphere2_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 48 -243.47256119107183;
createNode animCurveTA -n "nurbsSphere1_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 48 -600;
createNode animCurveTA -n "nurbsSphere3_rotateY";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 0 48 254.16000000001054;
createNode animCurveTL -n "pointLight1_translateX";
	setAttr ".tan" 9;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 6.4545434117847247 48 -9.2894456801253238;
select -ne :time1;
	setAttr ".o" 22;
select -ne :renderPartition;
	setAttr -s 4 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :lambert1;
	setAttr ".c" -type "float3" 0 0 0 ;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultLightSet;
select -ne :hyperGraphLayout;
	setAttr ".cch" no;
	setAttr ".ihi" 2;
	setAttr ".nds" 0;
	setAttr ".img" -type "string" "";
	setAttr ".ims" 1;
connectAttr "polyCube1.out" "pCubeShape1.i";
connectAttr "polyCube2.out" "pCubeShape2.i";
connectAttr "polyCube3.out" "pCubeShape7.i";
connectAttr "nurbsSphere2_rotateY.o" "nurbsSphere2.ry";
connectAttr "makeNurbSphere2.os" "nurbsSphereShape2.cr";
connectAttr "nurbsSphere1_rotateY.o" "nurbsSphere1.ry";
connectAttr "makeNurbSphere1.os" "nurbsSphereShape1.cr";
connectAttr "nurbsSphere3_rotateY.o" "nurbsSphere3.ry";
connectAttr "makeNurbSphere3.os" "nurbsSphereShape3.cr";
connectAttr "pointLight1_translateX.o" "pointLight1.tx";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "lambert2SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "lambert3SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "lambert2.oc" "lambert2SG.ss";
connectAttr "pCubeShape7.iog" "lambert2SG.dsm" -na;
connectAttr "|group2|pCube6|pCubeShape6.iog" "lambert2SG.dsm" -na;
connectAttr "|group2|pCube5|pCubeShape5.iog" "lambert2SG.dsm" -na;
connectAttr "|group2|pCube4|pCubeShape4.iog" "lambert2SG.dsm" -na;
connectAttr "|group1|pCube6|pCubeShape6.iog" "lambert2SG.dsm" -na;
connectAttr "|group1|pCube5|pCubeShape5.iog" "lambert2SG.dsm" -na;
connectAttr "|group1|pCube4|pCubeShape4.iog" "lambert2SG.dsm" -na;
connectAttr "pCubeShape3.iog" "lambert2SG.dsm" -na;
connectAttr "pCubeShape2.iog" "lambert2SG.dsm" -na;
connectAttr "pCubeShape1.iog" "lambert2SG.dsm" -na;
connectAttr "lambert2SG.msg" "materialInfo1.sg";
connectAttr "lambert3.oc" "lambert3SG.ss";
connectAttr "nurbsSphereShape3.iog" "lambert3SG.dsm" -na;
connectAttr "nurbsSphereShape1.iog" "lambert3SG.dsm" -na;
connectAttr "nurbsSphereShape2.iog" "lambert3SG.dsm" -na;
connectAttr "lambert3SG.msg" "materialInfo2.sg";
connectAttr "lambert2SG.pa" ":renderPartition.st" -na;
connectAttr "lambert3SG.pa" ":renderPartition.st" -na;
connectAttr "lambert2.msg" ":defaultShaderList1.s" -na;
connectAttr "lambert3.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "pointLightShape1.ltd" ":lightList1.l" -na;
connectAttr "pointLight1.iog" ":defaultLightSet.dsm" -na;
// End of GroundShadow.ma
