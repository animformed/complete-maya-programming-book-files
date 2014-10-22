//Maya ASCII 4.0 scene
//Name: Clock.ma
//Last modified: Mon, Dec 10, 2001 07:10:20 AM
requires maya "4.0";
currentUnit -l centimeter -a degree -t film;
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
	setAttr ".t" -type "double3" -4.4408920985006262e-015 100.00591045553155 
		2.1317594457566435e-014 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100;
	setAttr ".ow" 40.198952689049996;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".tp" -type "double3" 0.93984962406014949 0 -0.54511278195490886 ;
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
createNode transform -n "minute_hand";
	setAttr ".t" -type "double3" 0 0 -1.4393939393939394 ;
	setAttr ".s" -type "double3" 0.59943967199408543 0.86457644999147154 12.708526650041255 ;
	setAttr ".rp" -type "double3" 0 0 1.439393939393939 ;
	setAttr ".sp" -type "double3" 0 0 0.13004833528765194 ;
	setAttr ".spt" -type "double3" 0 0 1.3093456041062879 ;
createNode nurbsSurface -n "minute_handShape" -p "minute_hand";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr -s 16 ".cp[0:15]" -type "double3" 0 0 -0.12684303398389263 
		0.066666666666666374 0 0 0.16296296296296248 0 0 0.23411522633744819 0 0 
		0 0 -0.12684303398389263 0.022222222222222032 0 0 0.054320987654320821 0 
		0 0.078038408779149415 0 0 0 0 -0.12684303398389263 -0.022222222222222032 
		0 0 -0.054320987654320807 0 0 -0.078038408779149401 0 0 0 0 -0.12684303398389263 
		-0.066666666666666374 0 0 -0.16296296296296248 0 0 -0.23411522633744819 0 
		0;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "nurbsCircle1";
	setAttr ".r" -type "double3" 89.999999999999986 0 0 ;
	setAttr ".s" -type "double3" 47.685442258350477 47.685442258350477 47.685442258350477 ;
createNode nurbsCurve -n "nurbsCircleShape1" -p "nurbsCircle1";
	setAttr -k off ".v";
	setAttr ".tw" yes;
createNode transform -n "nurbsSquare1";
	setAttr ".t" -type "double3" -7.3448275862068959 0 0 ;
createNode transform -n "pPlane1";
	setAttr ".t" -type "double3" -8.5344827586206922 0 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
createNode mesh -n "pPlaneShape1" -p "pPlane1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".ns" 1;
createNode transform -n "nurbsCircle2";
	setAttr ".r" -type "double3" 89.999999999999986 0 0 ;
	setAttr ".s" -type "double3" 49.697039135863918 49.697039135863918 49.697039135863918 ;
createNode nurbsCurve -n "nurbsCircleShape2" -p "nurbsCircle2";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		1 28 0 no 3
		29 0 0.22392895220661571 0.44785790441323142 0.67178685661984727 0.89571580882646296
		 1.1196447610330786 1.3435737132396943 1.56750266544631 1.7914316176529257
		 2.0153605698595416 2.2392895220661573 2.463218474272773 2.6871474264793886
		 2.9110763786860043 3.13500533089262 3.3589342830992357 3.5828632353058514
		 3.8067921875124671 4.0307211397190823 4.254650091925698 4.4785790441323137
		 4.7025079963389294 4.926436948545545 5.1503659007521607 5.3742948529587764
		 5.5982238051653921 5.8221527573720078 6.0460817095786235 6.2700106617852391
		
		29
		1.2246063538223773e-017 0.20000000000000001 0
		-0.044504186791262869 0.19498558243636474 0
		-0.086776747823511621 0.18019377358048383 0
		-0.12469796037174673 0.15636629649360598 0
		-0.15636629649360598 0.1246979603717467 0
		-0.18019377358048383 0.086776747823511635 0
		-0.19498558243636471 0.04450418679126289 0
		-0.20000000000000001 1.2246063538223773e-017 0
		-0.19498558243636474 -0.044504186791262869 0
		-0.18019377358048383 -0.086776747823511621 0
		-0.15636629649360598 -0.12469796037174673 0
		-0.1246979603717467 -0.15636629649360598 0
		-0.086776747823511635 -0.18019377358048383 0
		-0.04450418679126289 -0.19498558243636471 0
		-1.2246063538223773e-017 -0.20000000000000001 0
		0.044504186791262869 -0.19498558243636474 0
		0.086776747823511621 -0.18019377358048383 0
		0.12469796037174673 -0.15636629649360598 0
		0.15636629649360598 -0.1246979603717467 0
		0.18019377358048383 -0.086776747823511635 0
		0.19498558243636471 -0.04450418679126289 0
		0.20000000000000001 -1.2246063538223773e-017 0
		0.19498558243636474 0.044504186791262869 0
		0.18019377358048383 0.086776747823511621 0
		0.15636629649360598 0.12469796037174673 0
		0.1246979603717467 0.15636629649360598 0
		0.086776747823511635 0.18019377358048383 0
		0.04450418679126289 0.19498558243636471 0
		1.2246063538223773e-017 0.20000000000000001 0
		;
createNode transform -n "nurbsTorus1";
createNode nurbsSurface -n "nurbsTorusShape1" -p "nurbsTorus1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode transform -n "pPlane2";
	setAttr ".t" -type "double3" 8.7413793103448238 0 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
createNode mesh -n "pPlaneShape2" -p "pPlane2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane3";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 8.793103448275863 ;
	setAttr ".r" -type "double3" 0 -89.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" -8.7931034482758612 0 -1.1010349720075692e-014 ;
	setAttr ".rpt" -type "double3" 8.7931034482758683 0 -8.7931034482758506 ;
	setAttr ".sp" -type "double3" -1.9412729015400032e-006 0 -1.2417254369026889e-014 ;
	setAttr ".spt" -type "double3" -1.5070029635658699e-006 0 5.3118254800837851e-015 ;
createNode mesh -n "pPlaneShape3" -p "pPlane3";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane5";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 -9.1034482758620641 ;
	setAttr ".r" -type "double3" 0 -89.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" 9 0 0.051724137931040692 ;
	setAttr ".rpt" -type "double3" -9.0517241379310356 0 8.9482758620689609 ;
	setAttr ".sp" -type "double3" 5.0667222685571307 0 0.090391697355216766 ;
	setAttr ".spt" -type "double3" 3.9332777314428657 0 -0.03866755942417547 ;
createNode mesh -n "pPlaneShape5" -p "pPlane5";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane6";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 -9.1034482758620641 ;
	setAttr ".r" -type "double3" 0 -59.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" 9 0 0.051724137931040692 ;
	setAttr ".rpt" -type "double3" -9.0517241379310356 0 8.9482758620689609 ;
	setAttr ".sp" -type "double3" 5.0667222685571307 0 0.090391697355216766 ;
	setAttr ".spt" -type "double3" 3.9332777314428657 0 -0.03866755942417547 ;
createNode mesh -n "pPlaneShape6" -p "pPlane6";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane7";
	setAttr ".t" -type "double3" -7.8200907030254809 0 -4.6482426932991894 ;
	setAttr ".r" -type "double3" 0 -29.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962969 1 0.57222222222221764 ;
	setAttr ".rp" -type "double3" 9.0000000000000036 0 0.051724137931039679 ;
	setAttr ".rpt" -type "double3" -1.2316334349055698 0 4.4930702795060888 ;
	setAttr ".sp" -type "double3" 5.0667222685571307 0 0.090391697355216766 ;
	setAttr ".spt" -type "double3" 3.933277731442872 0 -0.038667559424176483 ;
createNode mesh -n "pPlaneShape7" -p "pPlane7";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane8";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 -9.1034482758620641 ;
	setAttr ".r" -type "double3" 7.0195835743237771e-015 -119.99999999999997 
		0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" 9 0 0.051724137931040692 ;
	setAttr ".rpt" -type "double3" -9.0517241379310356 0 8.9482758620689609 ;
	setAttr ".sp" -type "double3" 5.0667222685571307 0 0.090391697355216766 ;
	setAttr ".spt" -type "double3" 3.9332777314428657 0 -0.03866755942417547 ;
createNode mesh -n "pPlaneShape8" -p "pPlane8";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane9";
	setAttr ".t" -type "double3" 7.7683665650944267 0 -4.558653858424945 ;
	setAttr ".r" -type "double3" 7.0195835743237771e-015 210.00000000000006 
		0 ;
	setAttr ".s" -type "double3" 1.7762962962962972 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" 9.0000000000000071 0 0.051724137931039665 ;
	setAttr ".rpt" -type "double3" -16.820090703025482 0 4.40348144463184 ;
	setAttr ".sp" -type "double3" 5.0667222685571307 0 0.090391697355216766 ;
	setAttr ".spt" -type "double3" 3.9332777314428724 0 -0.038667559424176497 ;
createNode mesh -n "pPlaneShape9" -p "pPlane9";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane10";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 8.793103448275863 ;
	setAttr ".r" -type "double3" 7.0195835743237771e-015 -119.99999999999997 
		0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" -8.7931034482758612 0 -1.1010349720075692e-014 ;
	setAttr ".rpt" -type "double3" 8.7931034482758683 0 -8.7931034482758506 ;
	setAttr ".sp" -type "double3" -1.9412729015400032e-006 0 -1.2417254369026889e-014 ;
	setAttr ".spt" -type "double3" -1.5070029635658699e-006 0 5.3118254800837851e-015 ;
createNode mesh -n "pPlaneShape10" -p "pPlane10";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane11";
	setAttr ".t" -type "double3" -7.6150509643114406 0 4.3965517241379342 ;
	setAttr ".r" -type "double3" 7.0195835743237771e-015 210.00000000000006 
		0 ;
	setAttr ".s" -type "double3" 1.7762962962962972 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" -8.7931034482758648 0 -1.1010349720075692e-014 ;
	setAttr ".rpt" -type "double3" 16.408154412587315 0 -4.3965517241379182 ;
	setAttr ".sp" -type "double3" -1.9412729015400032e-006 0 -1.2417254369026889e-014 ;
	setAttr ".spt" -type "double3" -1.5070029635658705e-006 0 5.3118254800837851e-015 ;
createNode mesh -n "pPlaneShape11" -p "pPlane11";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane12";
	setAttr ".t" -type "double3" -7.1054273576010019e-015 0 8.793103448275863 ;
	setAttr ".r" -type "double3" 0 -59.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962967 1 0.57222222222221741 ;
	setAttr ".rp" -type "double3" -8.7931034482758612 0 -1.1010349720075692e-014 ;
	setAttr ".rpt" -type "double3" 8.7931034482758683 0 -8.7931034482758506 ;
	setAttr ".sp" -type "double3" -1.9412729015400032e-006 0 -1.2417254369026889e-014 ;
	setAttr ".spt" -type "double3" -1.5070029635658699e-006 0 5.3118254800837851e-015 ;
createNode mesh -n "pPlaneShape12" -p "pPlane12";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "pPlane13";
	setAttr ".t" -type "double3" 7.6150509643114423 0 4.3965517241379413 ;
	setAttr ".r" -type "double3" 0 -29.999999999999972 0 ;
	setAttr ".s" -type "double3" 1.7762962962962969 1 0.57222222222221764 ;
	setAttr ".rp" -type "double3" -8.793103448275863 0 -1.1010349720075695e-014 ;
	setAttr ".rpt" -type "double3" 1.1780524839644229 0 -4.3965517241379262 ;
	setAttr ".sp" -type "double3" -1.9412729015400032e-006 0 -1.2417254369026889e-014 ;
	setAttr ".spt" -type "double3" -1.5070029635658703e-006 0 5.3118254800837835e-015 ;
createNode mesh -n "pPlaneShape13" -p "pPlane13";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 4 ".uvst[0].uvsp[0:3]" -type "float2" 0 0 1 0 
		0 1 1 1;
	setAttr ".cuvs" -type "string" "map1";
	setAttr -s 4 ".vt[0:3]"  -0.5 -1.110223e-016 0.5 0.5 -1.110223e-016 
		0.5 -0.5 1.110223e-016 -0.5 0.5 1.110223e-016 -0.5;
	setAttr -s 4 ".ed[0:3]"  0 1 0 0 2 
		0 1 3 0 2 3 0;
	setAttr ".fc[0]" -type "polyFaces" 
		f 4 0 2 -4 -2 
		mu 0 4 0 1 3 2 ;
	setAttr ".ns" 1;
createNode transform -n "nurbsCylinder1";
	setAttr ".t" -type "double3" 0 -0.22788137809518627 0 ;
	setAttr ".r" -type "double3" 90 0 0 ;
createNode nurbsSurface -n "nurbsCylinderShape1" -p "nurbsCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode nurbsSurface -n "revolvebottomCap2" -p "nurbsCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
createNode nurbsSurface -n "revolvetopCap2" -p "nurbsCylinder1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".tw" yes;
	setAttr ".dvu" 0;
	setAttr ".dvv" 0;
	setAttr ".cpr" 4;
	setAttr ".cps" 1;
createNode transform -n "hour_hand";
	setAttr ".t" -type "double3" 0 0 -1.4393939393939394 ;
	setAttr ".r" -type "double3" 0 -60.000000000000007 0 ;
	setAttr ".s" -type "double3" 0.78704275120993139 0.86457644999147154 8.1899393966932497 ;
	setAttr ".rp" -type "double3" 0 0 1.439393939393939 ;
	setAttr ".sp" -type "double3" 0 0 0.13004833528765194 ;
	setAttr ".spt" -type "double3" 0 0 1.3093456041062879 ;
createNode nurbsSurface -n "hour_handShape" -p "hour_hand";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".dvu" 3;
	setAttr ".dvv" 3;
	setAttr ".cpr" 15;
	setAttr ".cps" 4;
	setAttr ".cc" -type "nurbsSurface" 
		3 3 0 0 no 
		6 0 0 0 1 1 1
		6 0 0 0 1 1 1
		
		16
		-0.5 -3.0615158845559431e-017 0.5
		-0.43333333333333363 -1.0205052948519812e-017 0.16666666666666669
		-0.33703703703703752 1.0205052948519809e-017 -0.16666666666666663
		-0.26588477366255181 3.0615158845559431e-017 -0.5
		-0.16666666666666669 -3.0615158845559431e-017 0.5
		-0.14444444444444465 -1.0205052948519812e-017 0.16666666666666669
		-0.11234567901234586 1.0205052948519809e-017 -0.16666666666666663
		-0.08862825788751727 3.0615158845559431e-017 -0.5
		0.16666666666666663 -3.0615158845559431e-017 0.5
		0.1444444444444446 -1.0205052948519812e-017 0.16666666666666669
		0.11234567901234582 1.0205052948519809e-017 -0.16666666666666663
		0.088628257887517228 3.0615158845559431e-017 -0.5
		0.5 -3.0615158845559431e-017 0.5
		0.43333333333333363 -1.0205052948519812e-017 0.16666666666666669
		0.33703703703703752 1.0205052948519809e-017 -0.16666666666666663
		0.26588477366255181 3.0615158845559431e-017 -0.5
		
		;
	setAttr ".nufa" 4.5;
	setAttr ".nvfa" 4.5;
createNode lightLinker -n "lightLinker1";
createNode brush -n "brush1";
createNode displayLayerManager -n "layerManager";
	setAttr -s 2 ".dli[1]"  1;
	setAttr -s 2 ".dli";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
createNode renderLayer -s -n "globalRender";
createNode makeNurbPlane -n "makeNurbPlane1";
	setAttr ".ax" -type "double3" 0 1 0 ;
createNode makeNurbCircle -n "makeNurbCircle1";
	setAttr ".r" 0.20000000000000001;
	setAttr ".d" 1;
	setAttr ".s" 28;
createNode polyPlane -n "polyPlane1";
	setAttr ".sw" 1;
	setAttr ".sh" 1;
createNode makeNurbTorus -n "makeNurbTorus1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".r" 9.5868;
	setAttr ".s" 62;
	setAttr ".hr" 0.050000000000000003;
createNode blinn -n "blinn1";
	setAttr ".c" -type "float3" 0 0 0 ;
	setAttr ".ic" -type "float3" 0.58399802 0.78600001 0.60025918 ;
	setAttr ".rfl" 0;
	setAttr ".ec" 0;
	setAttr ".sro" 0;
createNode shadingEngine -n "blinn1SG";
	setAttr ".ihi" 0;
	setAttr -s 13 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
createNode blinn -n "blinn2";
	setAttr ".c" -type "float3" 0 0 0 ;
	setAttr ".sc" -type "float3" 0 0 0 ;
createNode shadingEngine -n "blinn2SG";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
createNode displayLayer -n "layer1";
	setAttr ".dt" 2;
	setAttr ".do" 1;
createNode makeNurbCylinder -n "makeNurbCylinder1";
	setAttr ".ax" -type "double3" 0 0 1 ;
	setAttr ".r" 9.870000000000001;
	setAttr ".s" 29;
	setAttr ".hr" 0.01;
createNode revolve -n "revolvebottomCap1";
	setAttr ".ihi" 1;
createNode revolve -n "revolvetopCap1";
	setAttr ".ihi" 1;
createNode blinn -n "blinn3";
	setAttr ".c" -type "float3" 0 0 0 ;
	setAttr ".ic" -type "float3" 0.255712 0.48800001 0.4850964 ;
	setAttr ".sc" -type "float3" 0 0 0 ;
createNode shadingEngine -n "blinn3SG";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
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
		+ "		modelPanel -edit -l \"Top View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"top\" \n"
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
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Side View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Side View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"side\" \n"
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
		+ "		modelPanel -edit -l \"Side View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"side\" \n"
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
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Front View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Front View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"front\" \n"
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
		+ "		modelPanel -edit -l \"Front View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"front\" \n"
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
		+ "	$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Persp View\"`;\n"
		+ "	if (\"\" == $panelName) {\n"
		+ "		if ($useSceneConfig) {\n"
		+ "			$panelName = `modelPanel -unParent -l \"Persp View\" -mbv $menusOkayInPanels `;\n"
		+ "			$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"persp\" \n"
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
		+ "		modelPanel -edit -l \"Persp View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "		$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"persp\" \n"
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
		+ "                -zoom 0.4925\n"
		+ "                -animateTransition 0\n"
		+ "                -showShapes 0\n"
		+ "                -showDeformers 0\n"
		+ "                -showExpressions 0\n"
		+ "                -showConstraints 0\n"
		+ "                -showUnderworld 0\n"
		+ "                -showInvisible 0\n"
		+ "                -transitionFrames 5\n"
		+ "                -currentNode \"nurbsSquare1\" \n"
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
		+ "                -zoom 0.4925\n"
		+ "                -animateTransition 0\n"
		+ "                -showShapes 0\n"
		+ "                -showDeformers 0\n"
		+ "                -showExpressions 0\n"
		+ "                -showConstraints 0\n"
		+ "                -showUnderworld 0\n"
		+ "                -showInvisible 0\n"
		+ "                -transitionFrames 5\n"
		+ "                -currentNode \"nurbsSquare1\" \n"
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
		+ "	if ($useSceneConfig) {\n"
		+ "		scriptedPanel -e -to $panelName;\n"
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
		+ "					\"Top View\"\n"
		+ "					\"modelPanel\"\n"
		+ "					\"$panelName = `modelPanel -unParent -l \\\"Top View\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera top` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "					\"modelPanel -edit -l \\\"Top View\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera top` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "				$configName;\n"
		+ "            setNamedPanelLayout \"Current Layout\";\n"
		+ "        }\n"
		+ "        panelHistory -e -clear mainPanelHistory;\n"
		+ "        setFocus `paneLayout -q -p1 $gMainPane`;\n"
		+ "        sceneUIReplacement -deleteRemaining;\n"
		+ "        sceneUIReplacement -clear;\n"
		+ "	}\n"
		+ "grid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\n"
		+ "}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 48 -ast 1 -aet 48 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 5 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 5 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :hyperGraphLayout;
	setAttr ".cch" no;
	setAttr ".ihi" 2;
	setAttr ".nds" 0;
	setAttr ".img" -type "string" "";
	setAttr ".ims" 1;
connectAttr "makeNurbPlane1.os" "minute_handShape.cr";
connectAttr "layer1.di" "nurbsCircle1.do";
connectAttr "makeNurbCircle1.oc" "nurbsCircleShape1.cr";
connectAttr "layer1.di" "nurbsCircleShape1.do";
connectAttr "layer1.di" "pPlane1.do";
connectAttr "polyPlane1.out" "pPlaneShape1.i";
connectAttr "layer1.di" "pPlaneShape1.do";
connectAttr "layer1.di" "nurbsCircle2.do";
connectAttr "layer1.di" "nurbsCircleShape2.do";
connectAttr "layer1.di" "nurbsTorus1.do";
connectAttr "makeNurbTorus1.os" "nurbsTorusShape1.cr";
connectAttr "layer1.di" "nurbsTorusShape1.do";
connectAttr "layer1.di" "pPlane2.do";
connectAttr "layer1.di" "pPlaneShape2.do";
connectAttr "layer1.di" "pPlane3.do";
connectAttr "layer1.di" "pPlaneShape3.do";
connectAttr "layer1.di" "pPlane5.do";
connectAttr "layer1.di" "pPlaneShape5.do";
connectAttr "layer1.di" "pPlane6.do";
connectAttr "layer1.di" "pPlaneShape6.do";
connectAttr "layer1.di" "pPlane7.do";
connectAttr "layer1.di" "pPlaneShape7.do";
connectAttr "layer1.di" "pPlane8.do";
connectAttr "layer1.di" "pPlaneShape8.do";
connectAttr "layer1.di" "pPlane9.do";
connectAttr "layer1.di" "pPlaneShape9.do";
connectAttr "layer1.di" "pPlane10.do";
connectAttr "layer1.di" "pPlaneShape10.do";
connectAttr "layer1.di" "pPlane11.do";
connectAttr "layer1.di" "pPlaneShape11.do";
connectAttr "layer1.di" "pPlane12.do";
connectAttr "layer1.di" "pPlaneShape12.do";
connectAttr "layer1.di" "pPlane13.do";
connectAttr "layer1.di" "pPlaneShape13.do";
connectAttr "layer1.di" "nurbsCylinder1.do";
connectAttr "makeNurbCylinder1.os" "nurbsCylinderShape1.cr";
connectAttr "layer1.di" "nurbsCylinderShape1.do";
connectAttr "revolvebottomCap1.os" "revolvebottomCap2.cr";
connectAttr "layer1.di" "revolvebottomCap2.do";
connectAttr "revolvetopCap1.os" "revolvetopCap2.cr";
connectAttr "layer1.di" "revolvetopCap2.do";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "blinn1SG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[3].llnk";
connectAttr "blinn2SG.msg" "lightLinker1.lnk[3].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[4].llnk";
connectAttr "blinn3SG.msg" "lightLinker1.lnk[4].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "blinn1.oc" "blinn1SG.ss";
connectAttr "nurbsTorusShape1.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape13.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape12.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape11.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape10.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape9.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape8.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape7.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape6.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape5.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape3.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape2.iog" "blinn1SG.dsm" -na;
connectAttr "pPlaneShape1.iog" "blinn1SG.dsm" -na;
connectAttr "blinn1SG.msg" "materialInfo1.sg";
connectAttr "blinn2.oc" "blinn2SG.ss";
connectAttr "minute_handShape.iog" "blinn2SG.dsm" -na;
connectAttr "hour_handShape.iog" "blinn2SG.dsm" -na;
connectAttr "blinn2SG.msg" "materialInfo2.sg";
connectAttr "layerManager.dli[1]" "layer1.id";
connectAttr "makeNurbCylinder1.bcc" "revolvebottomCap1.ic";
connectAttr "makeNurbCylinder1.p" "revolvebottomCap1.p";
connectAttr "makeNurbCylinder1.ax" "revolvebottomCap1.ax";
connectAttr "makeNurbCylinder1.asd" "revolvebottomCap1.esw";
connectAttr "makeNurbCylinder1.s" "revolvebottomCap1.s";
connectAttr "makeNurbCylinder1.d" "revolvebottomCap1.d";
connectAttr "makeNurbCylinder1.ut" "revolvebottomCap1.ut";
connectAttr "makeNurbCylinder1.tol" "revolvebottomCap1.tol";
connectAttr "makeNurbCylinder1.tcc" "revolvetopCap1.ic";
connectAttr "makeNurbCylinder1.p" "revolvetopCap1.p";
connectAttr "makeNurbCylinder1.ax" "revolvetopCap1.ax";
connectAttr "makeNurbCylinder1.asd" "revolvetopCap1.esw";
connectAttr "makeNurbCylinder1.s" "revolvetopCap1.s";
connectAttr "makeNurbCylinder1.d" "revolvetopCap1.d";
connectAttr "makeNurbCylinder1.ut" "revolvetopCap1.ut";
connectAttr "makeNurbCylinder1.tol" "revolvetopCap1.tol";
connectAttr "blinn3.oc" "blinn3SG.ss";
connectAttr "nurbsCylinderShape1.iog" "blinn3SG.dsm" -na;
connectAttr "revolvebottomCap2.iog" "blinn3SG.dsm" -na;
connectAttr "revolvetopCap2.iog" "blinn3SG.dsm" -na;
connectAttr "blinn3SG.msg" "materialInfo3.sg";
connectAttr "blinn1SG.pa" ":renderPartition.st" -na;
connectAttr "blinn2SG.pa" ":renderPartition.st" -na;
connectAttr "blinn3SG.pa" ":renderPartition.st" -na;
connectAttr "blinn1.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn2.msg" ":defaultShaderList1.s" -na;
connectAttr "blinn3.msg" ":defaultShaderList1.s" -na;
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
// End of Clock.ma
