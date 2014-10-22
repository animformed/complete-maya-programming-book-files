//Maya ASCII 4.0 scene
//Name: MotionPathCone.ma
//Last modified: Wed, May 15, 2002 12:49:53 PM
requires maya "4.0";
requires "MayaMan_m4" "1.0.15";
currentUnit -l centimeter -a degree -t film;
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 14.861756461246719 11.322849377728467 25.95008963203415 ;
	setAttr ".r" -type "double3" -20.738352729603093 29.800000000000562 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 31.976333045781193;
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
createNode transform -n "myCurve";
createNode nurbsCurve -n "myCurveShape" -p "myCurve";
	setAttr -k off ".v";
	setAttr ".cc" -type "nurbsCurve" 
		3 6 0 no 3
		11 0 0 0 1 2 3 4 5 6 6 6
		9
		-11.815790191054692 0 1.9022671260006945
		-4.4280796093229 0 6.0127680811771462
		0.46625334097207727 0 4.5279509629022066
		-3.3195431240672164 0 -3.3195431240672164
		1.2309437780726391 0 -6.7969135282361748
		6.4139671439515169 0 -3.4059174843285867
		7.1176855677572703 0 3.8622785437727849
		11.105930534730103 0 6.130703930499017
		12.382731018798872 0 4.0831305295050662
		;
createNode transform -n "myCone";
createNode nurbsSurface -n "myConeShape" -p "myCone";
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
createNode lightLinker -n "lightLinker1";
createNode brush -n "brush1";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
createNode renderLayer -s -n "globalRender";
createNode script -n "MayaManNuggetDeleteScript";
	setAttr ".a" -type "string" (
		"if (`window -q -exists mayaManOptionsWindow`) { deleteUI -window mayaManOptionsWindow; }");
	setAttr ".st" 2;
createNode MayaManNugget -n "MayaManNugget";
	addAttr -is true -ci true -sn "cropr" -ln "CropRight" -bt "UNKN" -dv 1 
		-min 0 -max 1 -at "float";
	addAttr -is true -ci true -sn "eoqno" -ln "EOQuantization" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "selonly" -ln "SelectedOnly" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "eoqmax" -ln "EOQuantMax" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "qone" -ln "QuanOne" -bt "UNKN" -dv 255 -min 
		0 -max 65535 -at "long";
	addAttr -is true -ci true -sn "dlut" -ln "DisplayLUT" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "bdice" -ln "BinaryDicing" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "eochname" -ln "EOChannel" -bt "UNKN" -dt "stringArray";
	addAttr -is true -ci true -uac -sn "bgcv" -ln "BackgroundColVal" -bt "UNKN" 
		-at "float3" -nc 3;
	addAttr -is true -ci true -sn "bgcvr" -ln "BackgroundColValRed" -bt "UNKN" 
		-at "float" -p "BackgroundColVal";
	addAttr -is true -ci true -sn "bgcvg" -ln "BackgroundColValGreen" -bt "UNKN" 
		-at "float" -p "BackgroundColVal";
	addAttr -is true -ci true -sn "bgcvb" -ln "BackgroundColValBlue" -bt "UNKN" 
		-at "float" -p "BackgroundColVal";
	addAttr -is true -ci true -sn "maxrd" -ln "MaxRayDepth" -bt "UNKN" -dv 4 
		-min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "shdbv" -ln "ShadowBiasVal" -bt "UNKN" -dv 
		0.0099999997764825821 -min 0 -max 100 -at "float";
	addAttr -is true -ci true -sn "bftlo" -ln "BackfaceTolOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "srate" -ln "ShadingRate" -bt "UNKN" -dv 1 
		-min 9.9999997473787516e-005 -max 100 -at "float";
	addAttr -is true -ci true -sn "ren" -ln "Renderer" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "rmasp" -ln "ArchiveSearchPaths" -bt "UNKN" 
		-dt "stringArray";
	addAttr -is true -ci true -sn "retex" -ln "ReuseTextures" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "dtxsq" -ln "DelSequenceTex" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "radsvf" -ln "RadSaveFile" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "unx" -ln "UnixRib" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "rado" -ln "RadianceOn" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "cbval" -ln "CameraBlurVal" -bt "UNKN" -dv 
		30 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "renpri" -ln "RenderPriority" -bt "UNKN" -dv 
		1 -min 0 -max 2 -at "long";
	addAttr -is true -ci true -sn "prev8" -ln "Preview8Bit" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "rflru" -ln "ReflReuse" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "sbon" -ln "MBlurShadAndRefl" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "eoqmin" -ln "EOQuantMin" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "txvar" -ln "TextureVariance" -bt "UNKN" -dv 
		0.0010000000474974513 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "cropp" -ln "CropPadding" -bt "UNKN" -dv 10 
		-min 0 -max 100 -at "long";
	addAttr -is true -ci true -sn "alfred" -ln "OutputAlfred" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "buso" -ln "BucketSizeOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "cbon" -ln "CameraBlurOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "rflrs" -ln "ReflRayserver" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "rflo" -ln "ReflectionsOn" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "causo" -ln "CausticsOn" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "vbval" -ln "VertexBlurVal" -bt "UNKN" -dv 
		30 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "shadcast" -ln "ShadowCasting" -bt "UNKN" 
		-dv 2 -min 0 -max 3 -at "long";
	addAttr -is true -ci true -sn "trued" -ln "TrueDisplacement" -bt "UNKN" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "othro" -ln "oThresholdOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "cma" -ln "MaxScanlineCurvature" -bt "UNKN" 
		-dv 120 -min 1 -max 120 -at "float";
	addAttr -is true -ci true -sn "rmtsp" -ln "TextureSearchPaths" -bt "UNKN" 
		-dt "stringArray";
	addAttr -is true -ci true -sn "binrib" -ln "BinaryRib" -bt "UNKN" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "qdith" -ln "QuanDither" -bt "UNKN" -dv 0.5 
		-min 0 -max 1 -at "float";
	addAttr -is true -ci true -uac -sn "othrv" -ln "oThresholdVal" -bt "UNKN" 
		-at "float3" -nc 3;
	addAttr -is true -ci true -sn "othrvr" -ln "oThresholdValRed" -bt "UNKN" 
		-dv 0.99599999189376831 -at "float" -p "oThresholdVal";
	addAttr -is true -ci true -sn "othrvg" -ln "oThresholdValGreen" -bt "UNKN" 
		-dv 0.99599999189376831 -at "float" -p "oThresholdVal";
	addAttr -is true -ci true -sn "othrvb" -ln "oThresholdValBlue" -bt "UNKN" 
		-dv 0.99599999189376831 -at "float" -p "oThresholdVal";
	addAttr -is true -ci true -sn "txcache" -ln "TextureCache" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "filt" -ln "PixelFilter" -bt "UNKN" -min 0 
		-max 5 -at "long";
	addAttr -is true -ci true -sn "dext" -ln "DisplayExtension" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "qup" -ln "QuantizePlanes" -bt "UNKN" -min 
		0 -max 1 -at "long";
	addAttr -is true -ci true -sn "mins" -ln "MinSamples" -bt "UNKN" -dv 8 -min 
		1 -max 1000 -at "long";
	addAttr -is true -ci true -sn "server" -ln "Server" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "rmssp" -ln "ShaderSearchPaths" -bt "UNKN" 
		-dt "stringArray";
	addAttr -is true -ci true -sn "shadfilt" -ln "ShadowFilter" -bt "UNKN" -dv 
		3 -min 0 -max 3 -at "long";
	addAttr -is true -ci true -sn "txfilt" -ln "TextureFilter" -bt "UNKN" -min 
		0 -max 3 -at "long";
	addAttr -is true -ci true -sn "filtx" -ln "PixelFilterX" -bt "UNKN" -dv 
		3 -min 0.10000000149011612 -max 1000 -at "float";
	addAttr -is true -ci true -sn "verb" -ln "Verbose" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "gfltv" -ln "GeomFlatnessVal" -bt "UNKN" -dv 
		2.5 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "filty" -ln "PixelFilterY" -bt "UNKN" -dv 
		3 -min 0.10000000149011612 -max 1000 -at "float";
	addAttr -is true -ci true -sn "gzip" -ln "CompressRib" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "txmmv" -ln "TextureMemVal" -bt "UNKN" -dv 
		8192 -min 0 -max 999999 -at "long";
	addAttr -is true -ci true -sn "pxvar" -ln "PixelVar" -bt "UNKN" -dv 1 -min 
		0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "ribdir" -ln "RibDir" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "pmunix" -ln "PathMapUnixEntries" -bt "UNKN" 
		-dt "stringArray";
	addAttr -is true -ci true -sn "ribsty" -ln "RibStyle" -bt "UNKN" -dv 1 -min 
		0 -max 4 -at "long";
	addAttr -is true -ci true -sn "dchk" -ln "DisplayCheck" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "maxbnc" -ln "MaxBounce" -bt "UNKN" -dv 1 
		-min 1 -max 8 -at "long";
	addAttr -is true -ci true -sn "mbval" -ln "MotionBlurVal" -bt "UNKN" -dv 
		30 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "ssrs" -ln "ShadowShadingRateScale" -bt "UNKN" 
		-dv 5 -min 1 -max 40 -at "float";
	addAttr -is true -ci true -sn "shaddel" -ln "ShadowDelete" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "eyesv" -ln "EyeSplitsVal" -bt "UNKN" -dv 
		3 -min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "eyeso" -ln "EyeSplitsOn" -bt "UNKN" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "radvcs" -ln "RadianceVisCullSize" -bt "UNKN" 
		-min 0 -max 1000 -at "float";
	addAttr -is true -ci true -uac -sn "zthrv" -ln "zThresholdVal" -bt "UNKN" 
		-at "float3" -nc 3;
	addAttr -is true -ci true -sn "zthrvr" -ln "zThresholdValRed" -bt "UNKN" 
		-dv 1 -at "float" -p "zThresholdVal";
	addAttr -is true -ci true -sn "zthrvg" -ln "zThresholdValGreen" -bt "UNKN" 
		-dv 1 -at "float" -p "zThresholdVal";
	addAttr -is true -ci true -sn "zthrvb" -ln "zThresholdValBlue" -bt "UNKN" 
		-dv 1 -at "float" -p "zThresholdVal";
	addAttr -is true -ci true -sn "shadpre" -ln "ShadowPreviews" -bt "UNKN" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "causmpd" -ln "CausMaxPixelDist" -bt "UNKN" 
		-dv 16 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "zthro" -ln "zThresholdOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "rmdsp" -ln "DisplaySearchPaths" -bt "UNKN" 
		-dt "stringArray";
	addAttr -is true -ci true -sn "mtfo" -ln "MotionFactorOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "xgamm" -ln "ExpGamma" -bt "UNKN" -dv 1 -min 
		0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "crops" -ln "CropToSelected" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "delrib" -ln "DeleteRib" -bt "UNKN" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "cropt" -ln "CropTop" -bt "UNKN" -dv 1 -min 
		0 -max 1 -at "float";
	addAttr -is true -ci true -sn "rflmw" -ln "ReflMapWidth" -bt "UNKN" -dv 
		256 -min 64 -max 4096 -at "long";
	addAttr -is true -ci true -sn "htexp" -ln "HalfTexPreview" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "sprog" -ln "ShowProgress" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "exdo" -ln "ExtremeDispOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "lutm" -ln "ApplyLUTMode" -bt "UNKN" -min 
		0 -max 100 -at "long";
	addAttr -is true -ci true -sn "custdd" -ln "CustomDisplay" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "shadreu" -ln "ShadowReuse" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "shadren" -ln "ShadowRenders" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "dbgp" -ln "DisplayBgPreview" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "radsef" -ln "RadSeedFile" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "tqual" -ln "TemporalQual" -bt "UNKN" -dv 
		4 -min 1 -max 32 -at "long";
	addAttr -is true -ci true -sn "pmnt" -ln "PathMapNTEntries" -bt "UNKN" -dt "stringArray";
	addAttr -is true -ci true -sn "urw" -ln "UserRibWorld" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "sarch" -ln "ShadowArchives" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "gmemv" -ln "GeometryMemVal" -bt "UNKN" -dv 
		40000 -min 0 -max 100000 -at "long";
	addAttr -is true -ci true -sn "rsrs" -ln "ReflShadingRateScale" -bt "UNKN" 
		-dv 1 -min 1 -max 10 -at "float";
	addAttr -is true -ci true -sn "nrhs" -ln "NetRenderHosts" -bt "UNKN" -dt "stringArray";
	addAttr -is true -ci true -sn "rfldel" -ln "ReflDelete" -bt "UNKN" -dv 1 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "hidt" -ln "HiderType" -bt "UNKN" -min 0 -max 
		2 -at "long";
	addAttr -is true -ci true -sn "maxs" -ln "MaxSamples" -bt "UNKN" -dv 64 
		-min 1 -max 1000 -at "long";
	addAttr -is true -ci true -sn "exdv" -ln "ExtremeDispVal" -bt "UNKN" -dv 
		32 -min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "sdbug" -ln "ShowDebug" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "eoqone" -ln "EOQuantOne" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "eoqzero" -ln "EOQuantZero" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "camcl" -ln "EnableCameraClipping" -bt "UNKN" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "bsegs" -ln "BlurSegments" -bt "UNKN" -dv 
		1 -min 1 -max 5 -at "long";
	addAttr -is true -ci true -sn "qmax" -ln "QuanMax" -bt "UNKN" -dv 255 -min 
		0 -max 65535 -at "long";
	addAttr -is true -ci true -sn "dbgr" -ln "DisplayBgRender" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "pause" -ln "Pause" -bt "UNKN" -min 0 -max 
		1 -at "bool";
	addAttr -is true -ci true -sn "prmspec" -ln "PRManSpecular" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "occsvf" -ln "OccSaveFile" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "eotyp" -ln "EOType" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "outi" -ln "OutputInfo" -bt "UNKN" -min 0 
		-max 3 -at "long";
	addAttr -is true -ci true -sn "shaddisp" -ln "ShadowDispShaders" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "txszp" -ln "TexturePattern" -bt "UNKN" -dv 
		1 -min 0 -max 2 -at "long";
	addAttr -is true -ci true -sn "uro" -ln "UserRibOptions" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "rfldsp" -ln "ReflDisplace" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "tilex" -ln "TilesX" -bt "UNKN" -dv 1 -min 
		1 -max 16 -at "long";
	addAttr -is true -ci true -sn "sansm" -ln "SansMaterials" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "indi" -ln "IndirectIntensity" -bt "UNKN" 
		-dv 1 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "tiley" -ln "TilesY" -bt "UNKN" -dv 1 -min 
		1 -max 16 -at "long";
	addAttr -is true -ci true -sn "nren" -ln "NumRenders" -bt "UNKN" -dv 1 -min 
		1 -max 8 -at "long";
	addAttr -is true -ci true -sn "squalx" -ln "SpatialQualX" -bt "UNKN" -dv 
		1 -min 1 -max 32 -at "long";
	addAttr -is true -ci true -sn "squaly" -ln "SpatialQualY" -bt "UNKN" -dv 
		1 -min 1 -max 32 -at "long";
	addAttr -is true -ci true -sn "dchan" -ln "DisplayChannels" -bt "UNKN" -min 
		0 -max 3 -at "long";
	addAttr -is true -ci true -sn "postrnds" -ln "PostRenderScript" -bt "UNKN" 
		-dt "string";
	addAttr -is true -ci true -sn "fbstep" -ln "FramebufferStep" -bt "UNKN" 
		-dv 8 -min 1 -max 100 -at "long";
	addAttr -is true -ci true -sn "cropreg" -ln "CropToRegion" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "gflto" -ln "GeomFlatnessOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "dbg" -ln "DisplayBgImage" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "dtxsg" -ln "DelSingleTex" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "xgain" -ln "ExpGain" -bt "UNKN" -dv 1 -min 
		0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "txszm" -ln "TexResizeMethod" -bt "UNKN" -dv 
		2 -min 0 -max 2 -at "long";
	addAttr -is true -ci true -sn "txlerp" -ln "TexturesLerp" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "gmemo" -ln "GeometryMemOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "reldet" -ln "RelDetail" -bt "UNKN" -dv 1 
		-min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "qmin" -ln "QuanMin" -bt "UNKN" -min 0 -max 
		65535 -at "long";
	addAttr -is true -ci true -sn "shdbo" -ln "ShadowBiasOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "ncpu" -ln "NumCpus" -bt "UNKN" -dv 1 -min 
		1 -max 8 -at "long";
	addAttr -is true -ci true -sn "sdspy" -ln "AnimalDisplayDriverMode" -bt "UNKN" 
		-dv 1 -min 0 -max 2 -at "long";
	addAttr -is true -ci true -sn "deflig" -ln "DefaultLights" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "imgod" -ln "ImageOutputDir" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "nrfs" -ln "NetRenderFilesystem" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "radmpd" -ln "RadMaxPixelDist" -bt "UNKN" 
		-dv 10 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "oecdp" -ln "EODuringPreview" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "vbon" -ln "VertexBlurOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "txdfilt" -ln "TextureDispFilter" -bt "UNKN" 
		-min 0 -max 3 -at "long";
	addAttr -is true -ci true -sn "grdso" -ln "GridSizeOn" -bt "UNKN" -min 0 
		-max 1 -at "bool";
	addAttr -is true -ci true -sn "bftlv" -ln "BackfaceTolVal" -bt "UNKN" -dv 
		10 -min 0 -max 90 -at "float";
	addAttr -is true -ci true -sn "dbgseq" -ln "DisplayBgSequence" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "prefrms" -ln "PreFrameScript" -bt "UNKN" 
		-dt "string";
	addAttr -is true -ci true -sn "rads" -ln "RadSamples" -bt "UNKN" -dv 256 
		-min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "cropb" -ln "CropBottom" -bt "UNKN" -min 0 
		-max 1 -at "float";
	addAttr -is true -ci true -sn "rflmb" -ln "ReflMotionBlur" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "depthf" -ln "DepthFilterOn" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "txsamp" -ln "TextureSamples" -bt "UNKN" -dv 
		16 -min 1 -max 1000 -at "long";
	addAttr -is true -ci true -sn "eoditho" -ln "EODoDither" -bt "UNKN" -dt "Int32Array";
	addAttr -is true -ci true -sn "genrib" -ln "GenerateRibOnly" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "grdsv" -ln "GridSizeVal" -bt "UNKN" -dv 1024 
		-min 0 -max 9999 -at "long";
	addAttr -is true -ci true -sn "bgco" -ln "BackgroundColOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "twosid" -ln "TwoSided" -bt "UNKN" -dv 1 -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "smshd" -ln "SmoothShading" -bt "UNKN" -dv 
		1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "mtfv" -ln "MotionFactorVal" -bt "UNKN" -dv 
		1 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "rflmh" -ln "ReflMapHeight" -bt "UNKN" -dv 
		256 -min 64 -max 4096 -at "long";
	addAttr -is true -ci true -sn "mbon" -ln "MotionBlurOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "arch" -ln "CreateArchives" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "postfrms" -ln "PostFrameScript" -bt "UNKN" 
		-dt "string";
	addAttr -is true -ci true -sn "bdir" -ln "BlurDirection" -bt "UNKN" -min 
		0 -max 2 -at "long";
	addAttr -is true -ci true -sn "rflei" -ln "ReflEnvIntensity" -bt "UNKN" 
		-dv 1 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "cmr" -ln "MaxRaytracingCurvature" -bt "UNKN" 
		-dv 5 -min 1 -max 120 -at "float";
	addAttr -is true -ci true -sn "causng" -ln "CausNGather" -bt "UNKN" -dv 
		75 -min 0 -max 1000000 -at "long";
	addAttr -is true -ci true -sn "kcr" -ln "KeepCreases" -bt "UNKN" -dv 1 -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "busx" -ln "BucketSizeX" -bt "UNKN" -dv 32 
		-min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "occsef" -ln "OccSeedFile" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "busy" -ln "BucketSizeY" -bt "UNKN" -dv 32 
		-min 0 -max 1000 -at "long";
	addAttr -is true -ci true -sn "zerop" -ln "ZeroPadFilenames" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "ribbas" -ln "RibBase" -bt "UNKN" -dt "string";
	addAttr -is true -ci true -sn "shadsurf" -ln "ShadowSurfShaders" -bt "UNKN" 
		-min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "cropl" -ln "CropLeft" -bt "UNKN" -min 0 -max 
		1 -at "float";
	addAttr -is true -ci true -sn "causi" -ln "CausticIntensity" -bt "UNKN" 
		-dv 1 -min 0 -max 1000 -at "float";
	addAttr -is true -ci true -sn "sampx" -ln "PixelSamplesX" -bt "UNKN" -dv 
		2 -min 0.10000000149011612 -max 1000 -at "float";
	addAttr -is true -ci true -sn "sampy" -ln "PixelSamplesY" -bt "UNKN" -dv 
		2 -min 0.10000000149011612 -max 1000 -at "float";
	addAttr -is true -ci true -sn "clmpa" -ln "ClampToAlpha" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "txmmo" -ln "TextureMemOn" -bt "UNKN" -min 
		0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "dspren" -ln "DisplayRendering" -bt "UNKN" 
		-dv 1 -min 0 -max 1 -at "bool";
	addAttr -is true -ci true -sn "radme" -ln "RadMaxError" -bt "UNKN" -dv 0.10000000149011612 
		-min 0 -max 1 -at "float";
	addAttr -is true -ci true -sn "prernds" -ln "PreRenderScript" -bt "UNKN" 
		-dt "string";
	addAttr -is true -ci true -sn "minsb" -ln "MinShadowBias" -bt "UNKN" -dv 
		0.0099999997764825821 -min 0.0010000000474974513 -max 1000 -at "float";
	addAttr -is true -ci true -sn "eodithv" -ln "EODitherValue" -bt "UNKN" -dt "doubleArray";
	setAttr ".cch" no;
	setAttr ".ihi" 2;
	setAttr ".nds" 0;
	setAttr ".cropr" 1;
	setAttr ".eoqno" -type "Int32Array" 0 ;
	setAttr ".selonly" no;
	setAttr ".eoqmax" -type "Int32Array" 0 ;
	setAttr ".qone" 255;
	setAttr ".dlut" -type "string" "";
	setAttr ".bdice" no;
	setAttr ".eochname" -type "stringArray" 0  ;
	setAttr -k on ".bgcv" -type "float3" 0 0 0 ;
	setAttr -k on ".bgcv";
	setAttr ".maxrd" 4;
	setAttr ".shdbv" 0.0099999997764825821;
	setAttr ".bftlo" no;
	setAttr ".srate" 1;
	setAttr ".ren" -type "string" "Pixar - prman";
	setAttr ".rmasp" -type "stringArray" 0  ;
	setAttr ".retex" yes;
	setAttr ".dtxsq" no;
	setAttr ".radsvf" -type "string" "";
	setAttr ".unx" no;
	setAttr ".rado" no;
	setAttr ".cbval" 30;
	setAttr ".renpri" 1;
	setAttr ".prev8" no;
	setAttr ".rflru" no;
	setAttr ".sbon" no;
	setAttr ".eoqmin" -type "Int32Array" 0 ;
	setAttr ".txvar" 0.0010000000474974513;
	setAttr ".cropp" 10;
	setAttr ".alfred" no;
	setAttr ".buso" no;
	setAttr ".cbon" no;
	setAttr ".rflrs" no;
	setAttr ".rflo" yes;
	setAttr ".causo" no;
	setAttr ".vbval" 30;
	setAttr ".shadcast" 2;
	setAttr ".trued" yes;
	setAttr ".othro" no;
	setAttr ".cma" 120;
	setAttr ".rmtsp" -type "stringArray" 0  ;
	setAttr ".binrib" yes;
	setAttr ".qdith" 0.5;
	setAttr -k on ".othrv" -type "float3" 0.99599999 0.99599999 0.99599999 ;
	setAttr -k on ".othrv";
	setAttr ".txcache" -type "string" "$(PROJECTDIR)\\mayaman\\tex_cache";
	setAttr ".filt" 0;
	setAttr ".dext" -type "string" "tif";
	setAttr ".qup" 0;
	setAttr ".mins" 8;
	setAttr ".server" no;
	setAttr ".rmssp" -type "stringArray" 0  ;
	setAttr ".shadfilt" 3;
	setAttr ".txfilt" 0;
	setAttr ".filtx" 3;
	setAttr ".verb" no;
	setAttr ".gfltv" 2.5;
	setAttr ".filty" 3;
	setAttr ".gzip" no;
	setAttr ".txmmv" 8192;
	setAttr ".pxvar" 1;
	setAttr ".ribdir" -type "string" "$(PROJECTDIR)\\mayaman\\$(SCENENAME)";
	setAttr ".pmunix" -type "stringArray" 0  ;
	setAttr ".ribsty" 1;
	setAttr ".dchk" no;
	setAttr ".maxbnc" 1;
	setAttr ".mbval" 30;
	setAttr ".ssrs" 5;
	setAttr ".shaddel" yes;
	setAttr ".eyesv" 3;
	setAttr ".eyeso" yes;
	setAttr ".radvcs" 0;
	setAttr -k on ".zthrv" -type "float3" 1 1 1 ;
	setAttr -k on ".zthrv";
	setAttr ".shadpre" yes;
	setAttr ".causmpd" 16;
	setAttr ".zthro" no;
	setAttr ".rmdsp" -type "stringArray" 0  ;
	setAttr ".mtfo" no;
	setAttr ".xgamm" 1;
	setAttr ".crops" no;
	setAttr ".delrib" yes;
	setAttr ".cropt" 1;
	setAttr ".rflmw" 256;
	setAttr ".htexp" no;
	setAttr ".sprog" yes;
	setAttr ".exdo" no;
	setAttr ".lutm" 0;
	setAttr ".custdd" -type "string" "animal";
	setAttr ".shadreu" no;
	setAttr ".shadren" yes;
	setAttr ".dbgp" yes;
	setAttr ".radsef" -type "string" "";
	setAttr ".tqual" 4;
	setAttr ".pmnt" -type "stringArray" 0  ;
	setAttr ".urw" -type "string" "";
	setAttr ".sarch" yes;
	setAttr ".gmemv" 40000;
	setAttr ".rsrs" 1;
	setAttr ".nrhs" -type "stringArray" 0  ;
	setAttr ".rfldel" yes;
	setAttr ".hidt" 0;
	setAttr ".maxs" 64;
	setAttr ".exdv" 32;
	setAttr ".sdbug" no;
	setAttr ".eoqone" -type "Int32Array" 0 ;
	setAttr ".eoqzero" -type "Int32Array" 0 ;
	setAttr ".camcl" yes;
	setAttr ".bsegs" 1;
	setAttr ".qmax" 255;
	setAttr ".dbgr" no;
	setAttr ".pause" no;
	setAttr ".prmspec" yes;
	setAttr ".occsvf" -type "string" "";
	setAttr ".eotyp" -type "Int32Array" 0 ;
	setAttr ".outi" 0;
	setAttr ".shaddisp" no;
	setAttr ".txszp" 1;
	setAttr ".uro" -type "string" "";
	setAttr ".rfldsp" yes;
	setAttr ".tilex" 1;
	setAttr ".sansm" no;
	setAttr ".indi" 1;
	setAttr ".tiley" 1;
	setAttr ".nren" 1;
	setAttr ".squalx" 1;
	setAttr ".squaly" 1;
	setAttr ".dchan" 0;
	setAttr ".postrnds" -type "string" "";
	setAttr ".fbstep" 8;
	setAttr ".cropreg" no;
	setAttr ".gflto" no;
	setAttr ".dbg" -type "string" "";
	setAttr ".dtxsg" no;
	setAttr ".xgain" 1;
	setAttr ".txszm" 2;
	setAttr ".txlerp" yes;
	setAttr ".gmemo" no;
	setAttr ".reldet" 1;
	setAttr ".qmin" 0;
	setAttr ".shdbo" no;
	setAttr ".ncpu" 1;
	setAttr ".sdspy" 1;
	setAttr ".deflig" yes;
	setAttr ".imgod" -type "string" "$(PROJECTDIR)\\mayaman\\images";
	setAttr ".nrfs" no;
	setAttr ".radmpd" 10;
	setAttr ".oecdp" no;
	setAttr ".vbon" no;
	setAttr ".txdfilt" 0;
	setAttr ".grdso" no;
	setAttr ".bftlv" 10;
	setAttr ".dbgseq" no;
	setAttr ".prefrms" -type "string" "";
	setAttr ".rads" 256;
	setAttr ".cropb" 0;
	setAttr ".rflmb" no;
	setAttr ".depthf" yes;
	setAttr ".txsamp" 16;
	setAttr ".eoditho" -type "Int32Array" 0 ;
	setAttr ".genrib" no;
	setAttr ".grdsv" 1024;
	setAttr ".bgco" no;
	setAttr ".twosid" yes;
	setAttr ".smshd" yes;
	setAttr ".mtfv" 1;
	setAttr ".rflmh" 256;
	setAttr ".mbon" no;
	setAttr ".arch" no;
	setAttr ".postfrms" -type "string" "";
	setAttr ".bdir" 0;
	setAttr ".rflei" 1;
	setAttr ".cmr" 5;
	setAttr ".causng" 75;
	setAttr ".kcr" yes;
	setAttr ".busx" 32;
	setAttr ".occsef" -type "string" "";
	setAttr ".busy" 32;
	setAttr ".zerop" no;
	setAttr ".ribbas" -type "string" "untitled";
	setAttr ".shadsurf" no;
	setAttr ".cropl" 0;
	setAttr ".causi" 1;
	setAttr ".sampx" 2;
	setAttr ".sampy" 2;
	setAttr ".clmpa" no;
	setAttr ".txmmo" no;
	setAttr ".dspren" yes;
	setAttr ".radme" 0.10000000149011612;
	setAttr ".prernds" -type "string" "";
	setAttr ".minsb" 0.0099999997764825821;
	setAttr ".eodithv" -type "doubleArray" 0 ;
createNode script -n "uiConfigurationScriptNode";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n"
		+ "//\n"
		+ "//  This script is machine generated.  Edit at your own risk.\n"
		+ "//\n"
		+ "//\n"
		+ "global string $gMainPane;\n"
		+ "if (`paneLayout -exists $gMainPane`) {\n"
		+ "\tglobal int $gUseScenePanelConfig;\n"
		+ "\tint    $useSceneConfig = $gUseScenePanelConfig;\n"
		+ "\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n"
		+ "\tint    $nPanes = 0;\n"
		+ "\tstring $editorName;\n"
		+ "\tstring $panelName;\n"
		+ "\tstring $itemFilterName;\n"
		+ "\tstring $panelConfig;\n"
		+ "\t//\n"
		+ "\t//  get current state of the UI\n"
		+ "\t//\n"
		+ "\tsceneUIReplacement -update $gMainPane;\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Top View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `modelPanel -unParent -l \"Top View\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tmodelPanel -edit -l \"Top View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Side View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `modelPanel -unParent -l \"Side View\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tmodelPanel -edit -l \"Side View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Front View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `modelPanel -unParent -l \"Front View\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tmodelPanel -edit -l \"Front View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" \"Persp View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `modelPanel -unParent -l \"Persp View\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n"
		+ "            modelEditor -e \n"
		+ "                -camera \"persp\" \n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tmodelPanel -edit -l \"Persp View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n"
		+ "        modelEditor -e \n"
		+ "            -camera \"persp\" \n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" \"Outliner\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `outlinerPanel -unParent -l \"Outliner\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = $panelName;\n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\toutlinerPanel -edit -l \"Outliner\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" \"Graph Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"graphEditor\" -l \"Graph Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
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
		+ "\t\t\t$editorName = ($panelName+\"GraphEd\");\n"
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
		+ "                -clipTime \"off\" \n"
		+ "                $editorName;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Graph Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
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
		+ "\t\t\t$editorName = ($panelName+\"GraphEd\");\n"
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
		+ "                -clipTime \"off\" \n"
		+ "                $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\tif ($useSceneConfig) {\n"
		+ "\t\tscriptedPanel -e -to $panelName;\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" \"Dope Sheet\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"dopeSheetPanel\" -l \"Dope Sheet\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
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
		+ "\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n"
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
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Dope Sheet\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"OutlineEd\");\n"
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
		+ "\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n"
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
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" \"Trax Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"clipEditorPanel\" -l \"Trax Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"ClipEditor\");\n"
		+ "            clipEditor -e \n"
		+ "                -characterOutline \"clipEditorPanel1OutlineEditor\" \n"
		+ "                -menuContext \"track\" \n"
		+ "                $editorName;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Trax Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"ClipEditor\");\n"
		+ "            clipEditor -e \n"
		+ "                -characterOutline \"clipEditorPanel1OutlineEditor\" \n"
		+ "                -menuContext \"track\" \n"
		+ "                $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" \"Hypergraph\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperGraphPanel\" -l \"Hypergraph\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n"
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
		+ "                -currentNode \"myCurveShape\" \n"
		+ "                -freeform 0\n"
		+ "                -imageEnabled 0\n"
		+ "                -graphType \"DG\" \n"
		+ "                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n"
		+ "                $editorName;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Hypergraph\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n"
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
		+ "                -currentNode \"myCurveShape\" \n"
		+ "                -freeform 0\n"
		+ "                -imageEnabled 0\n"
		+ "                -graphType \"DG\" \n"
		+ "                -updateSelection 1\n"
		+ "                -updateNodeAdded 1\n"
		+ "                $editorName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" \"Hypershade\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"hyperShadePanel\" -l \"Hypershade\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Hypershade\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" \"Visor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"visorPanel\" -l \"Visor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Visor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" \"UV Texture Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"polyTexturePlacementPanel\" -l \"UV Texture Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"UV Texture Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"multiListerPanel\" \"Multilister\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"multiListerPanel\" -l \"Multilister\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Multilister\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" \"Render View\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"renderWindowPanel\" -l \"Render View\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Render View\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"blendShapePanel\" \"Blend Shape\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\tblendShapePanel -unParent -l \"Blend Shape\" -mbv $menusOkayInPanels ;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tblendShapePanel -edit -l \"Blend Shape\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" \"Dynamic Relationships\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynRelEdPanel\" -l \"Dynamic Relationships\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Dynamic Relationships\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextPanel \"devicePanel\" \"Devices\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\tdevicePanel -unParent -l \"Devices\" -mbv $menusOkayInPanels ;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tdevicePanel -edit -l \"Devices\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" \"Relationship Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"relationshipPanel\" -l \"Relationship Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Relationship Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" \"Reference Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"referenceEditorPanel\" -l \"Reference Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Reference Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" \"Component Editor\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"componentEditorPanel\" -l \"Component Editor\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Component Editor\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" \"Paint Effects\"`;\n"
		+ "\tif (\"\" == $panelName) {\n"
		+ "\t\tif ($useSceneConfig) {\n"
		+ "\t\t\t$panelName = `scriptedPanel -unParent  -type \"dynPaintScriptedPanelType\" -l \"Paint Effects\" -mbv $menusOkayInPanels `;\n"
		+ "\t\t}\n"
		+ "\t} else {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l \"Paint Effects\" -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n"
		+ "\t}\n"
		+ "\tif ($useSceneConfig) {\n"
		+ "        string $configName = `getPanel -cwl \"Current Layout\"`;\n"
		+ "        if (\"\" != $configName) {\n"
		+ "\t\t\tpanelConfiguration -edit -label \"Current Layout\"\n"
		+ "\t\t\t\t-defaultImage \"\"\n"
		+ "\t\t\t\t-image \"\"\n"
		+ "\t\t\t\t-sc false\n"
		+ "\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n"
		+ "\t\t\t\t-removeAllPanels\n"
		+ "\t\t\t\t-ap true\n"
		+ "\t\t\t\t\t\"Persp View\"\n"
		+ "\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l \\\"Persp View\\\" -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l \\\"Persp View\\\" -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -wireframeOnShaded 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 1\\n    -backfaceCulling 0\\n    -xray 0\\n    -displayTextures 0\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 1024\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -locators 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -shadows 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName\"\n"
		+ "\t\t\t\t$configName;\n"
		+ "            setNamedPanelLayout \"Current Layout\";\n"
		+ "        }\n"
		+ "        panelHistory -e -clear mainPanelHistory;\n"
		+ "        setFocus `paneLayout -q -p1 $gMainPane`;\n"
		+ "        sceneUIReplacement -deleteRemaining;\n"
		+ "        sceneUIReplacement -clear;\n"
		+ "\t}\n"
		+ "grid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold no -perspectiveLabelPosition axis -orthographicLabelPosition edge;\n"
		+ "}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 48 -ast 1 -aet 48 ";
	setAttr ".st" 6;
createNode makeNurbCone -n "makeNurbCone1";
	setAttr ".ax" -type "double3" 0 1 0 ;
	setAttr ".nsp" 14;
	setAttr ".hr" 4.5;
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
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
connectAttr "makeNurbCone1.os" "myConeShape.cr";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
connectAttr "myConeShape.iog" ":initialShadingGroup.dsm" -na;
// End of MotionPathCone.ma
