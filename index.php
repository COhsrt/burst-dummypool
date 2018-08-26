<?php
include_once "miningInfo.php";
header('Content-Type: application/json');

#echo json_encode($_GET, true);
#exit;

// get scoop from url or use 1750 as default
if (isset($_GET['scoop'])) {
	$scoop = $_GET['scoop'];
}
else {
	$scoop = 1750;
}
// always use this baseTarget, as it's not needed
$baseTarget = 1;
// always use this targetDeadline, as we don't care
$targetDeadline = 2592000; // 60*60*24*30

// If we have an info about this scoop we can output this
if ( isset($infoPerScoop[$scoop])) {
	$dummyMiningInfo = $infoPerScoop[$scoop];
}
else { // If not, we will use the default scoop; sorry
	$dummyMiningInfo = $infoPerScoop[1750];
}
$dummyMiningInfo['baseTarget'] = $baseTarget;
$dummyMiningInfo['targetDeadline'] = $targetDeadline;

$dummyDeadline = [
	'deadline' => 11111, // Miner Chokes, but doesn't invest more time in submitting nonces
];



switch ($_GET['requestType']) {
	case 'submitNonce':
		$dD = json_encode($dummyDeadline);
		echo $dD;
		break;
	case 'getMiningInfo':
	default:
		$dMI = json_encode($dummyMiningInfo);
		echo $dMI;
		break;
}
