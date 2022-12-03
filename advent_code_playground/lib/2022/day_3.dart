import 'package:collection/collection.dart';

void main() {
  final ruckSacks = parseRuckSacks(day3part1);
  final compartmentsInHalves = ruckSacks.map(getCompartments).toList();

  var prioritiesSum = 0;
  for (final e in compartmentsInHalves) {
    final commonLetter = getCommonLetterOf2(e[0], e[1]);
    final priority = getPriority(commonLetter);
    prioritiesSum += priority;
  }

  print('part one answer: $prioritiesSum');

  final ruckSacksInThree = sliceByThree(ruckSacks);

  var newPrioritiesSum = 0;
  for (final e in ruckSacksInThree) {
    final commonLetter = getCommonLettersOf3(e[0], e[1], e[2]);
    final priority = getPriority(commonLetter);
    newPrioritiesSum += priority;
  }

  print('part two answer: $newPrioritiesSum');
}

List<String> parseRuckSacks(String raw) {
  return raw.split('\n');
}

List<String> getCompartments(String rucksack) {
  final halfLength = rucksack.length ~/ 2;
  return [rucksack.substring(0, halfLength), rucksack.substring(halfLength)];
}

String getCommonLetterOf2(String string1, String string2) {
  final set1 = string1.split('').toSet();
  final set2 = string2.split('').toSet();

  return set1.intersection(set2).first;
}

String getCommonLettersOf3(String string1, String string2, String string3) {
  final set1 = string1.split('').toSet();
  final set2 = string2.split('').toSet();
  final set3 = string3.split('').toSet();

  return set1.intersection(set2).intersection(set3).first;
}

int getPriority(String commonLetter) {
  if (isLowerCase(commonLetter)) {
    final alpahabets = getLowerCaseAlphabet();
    final map = {
      for (var i = 0; i < 26; i++) ...{i + 1: alpahabets[i]}
    };
    return map.keys.where((element) => map[element] == commonLetter).first;
  } else {
    final alpahabets = getUpperCaseAlphabet();
    final map = {
      for (var i = 27; i < 53; i++) ...{i: alpahabets[i - 27]}
    };

    return map.keys.where((element) => map[element] == commonLetter).first;
  }
}

bool isLowerCase(String value) {
  if (value.codeUnitAt(0) < 97) return false;
  return true;
}

List<String> getLowerCaseAlphabet() {
  final alphabets = <String>[];
  for (var i = 97; i <= 122; i++) {
    alphabets.add(String.fromCharCode(i));
  }
  return alphabets;
}

List<String> getUpperCaseAlphabet() {
  final alphabets = <String>[];
  for (var i = 65; i <= 90; i++) {
    alphabets.add(String.fromCharCode(i));
  }
  return alphabets;
}

List<List<String>> sliceByThree(List<String> data) => data.slices(3).toList();

const day3part1example = '''
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';

const day3part1 = '''
PcPlnShmrLmBnmcwBhrmcmbHNGFGpwdFFwGNjNbGqNHH
tzQfRJfWZZztWzVtCTfRzFZjpFjNZjGLHbdHLDdjpb
CCQTzRLzvQVVfRzJfMPsnBlglgPmBgPmvSrl
RMfvbbszHTsssFPzDQPggpQJPQ
NSNcqVtLVGgDlpQBClVB
hmStGNNLhjNrpWLGSjWrZssbZTMMvTfMnThbRRTs
fTrTPGTbfftWBBmLjrJL
DqHwVMqVplDslmlZmpHVwNnShWZFdBBdjWBtWtdtWJSSLS
MNslpDvVHlwsmpQRgQgCfTTcvcRQ
pBBhRgDsMsswprBhvgRglZtFGFFRqZtZmRtNqtZPPN
TdmmzzmdZdqdGFtF
nmSccCVmSCpDCswMwl
NptqDsQtDTQzCvlzCpRlRp
jmZcndmjbZcjrmDvFMFFlwCvzFnF
jjgLVLrGcdDBNhWQTgHg
mLVhhfSMSTmMwClHGdpjDHjGdV
zPrZgJCgbsnrPtZzsCsbpRDjBRHnjGDRldRHppcG
JJrbsFrZqrgWbbqbrgWzJPNTwhTNCmmvfWCShhhmwwfm
ftgfljvgfgBTNvtggFDDGLGRDnMDzcQzncGt
VdbpbVdZwdwrsVVLRrMrDLDBGnBGcM
wmpWwWsHWBCCCPPvjvmSqlfTTmSNgN
jSqmzmmSSDRjLMLDwqjNcMMLTTflffWCCsRsTHnHVrfHWTsr
tdbgZpgBPdgGZGGFTHVpCsCVfVsJpnWl
FnPQFvbvhFFFbvBwScjhzcqSLLSzSN
bWdgrWwwFWbgzFWzrmNbdPqttChMSRnmqSPSnqtMRM
lcPJLDDPPfpMBCRJBtQtMh
lGDGjTGLLDHPPGjlPTsswsbHNFsNrFNFsrzr
VmtHfVhBLHVtlhphjZMdnQQZZqZmQDdzQQ
CPFwPWrvWgrfNgFPCMqZzMDDbznFTqqzDQ
NNPsfffPCsBLjpVltV
ssdBBJqJhlTJLsjTJqFFmnmmnnrcmpprmmmPcRlf
gqtqzSgWQWqmnRPPcNmmQM
GqbSVtGzvgvgWbZjjBhTdhBsTZBJBZ
jhNBsPDzLjsVhLSNzgvcvbcwbBWFcgtWCc
ZQQTTHHnGpMtnpdHpQJfMgrvWWFqbcWWGgrgwCCwwF
nHpmMnQQMmHpRnHRmMJnnTShPzljzjSNmSDhLsNSPtSh
GdqnBGFdlqzFnwdSCQZjZLLDZjZRvZLDVvgQ
PsptsTcftMfcTfhTghVDvvjnRNjVZnvV
WtPfJTfftJcMTrMnpccFwlCSCGFGCbCwJSbqBl
GjFLGhjRwFjNSjSdJCBBdQJddbBc
MVvMMHRzVtHlvlcQBQJHqdpQqCBC
vDgVztvvmrgrVRrMmsrsmZzZnWhGnNhGWTLfnLwTLhLTjngL
VljjQJSsrjjrCglsCjsgjVVfDLdZGMdvvGdQMzmvzcDQMc
HqPBtcpRWwtHbbFwBHZfmfpDfvffDfMfmGvM
PwHNbcwtqFqnwtNNqPNPPWBTThjhhVTCSJTThssVnSlJJV
GCccNCrrnCrpnzrnCDPcDDrvHHTBqTPhswqhPTBTTwBhTj
VfNmRtZgWWHdBdswdjZv
SmtQfgNmVFgVLVLVmrnMpcDLGCGLGDMpCp
CrdZdZmPPjrQdRPRDqDLBqBLBSWgWgLDzF
sQhTNphsVbhhhMJfhNVGqltVSzSllBzStlzFFFWB
hsMpwQhNMZmPmrwHRj
cNVpSVRpLHRLsVWWfnfsCshW
jvqjTgqZPlJZmbPPfbpswsPb
vlqdTZdtJvqdZjgqZrtRpQFtLFRQczHGzt
JJQndVQnQgTfNvGf
ljpbWbmNbDlGTvggGvZf
mpmRbMmmNDFDmScpzCsdzrnJrsCzrrnM
tNFtNFFzzjjzjBtVNZVbjZGlpSvTllpWwvnBlWGGBGCC
fPdcrrgPHrHMMMWlppGJSPwGSnGv
fmrqrhhfhdRddHrhQqQrfnLZjLtNttZjjRtzjFtRNj
sphRcpQRhfmnmfpptg
WVPlGLlSjCjSlGSHJJWZdmbmfvPmmnftbbgDdt
LJjjqVNjlnCTRcRhhsNcFF
vwwqttFjwgClRNCCvGNmZZMmJsPJjJpTdMpsZd
fBLVHHHrFnhHhnrVSTmfdPdPccTTPsMfsJ
QzVWzznzFbWNGNlt
vjMddVVmnWpdMndjvhhWfNLpfBsfLLZLBBSqqTZq
RFlrzQJPSRGzzzzgBZNsgBZTBflfgf
cQFDRHFDDGCJShCnvwVnnhCn
hgjlpRRLlPJJhTLJMDnwBndSPBNvMqnN
FGWVfZsmCbmVzrvtwCSMtMdnDMCw
VsVmVZfVQDmVFrrmzmGrHHTJgJjhHJcllglLQJRL
rrTVcTBgsjTffmfWHZTv
JLdnDlpGlGSLlpwJpHZfFvRZnWzWrHWqFH
wQDpDrdSlSCblCdwdSLlwQGBthPMsghNsVNVtCNNhNPjhs
CtCMvNhDMHfDDdffqtDtCflpJlBpvmWWJWwlpwFFvjwB
rGSbVGZrSsFJjlmBFZWp
rbbQgzVGrFVSPPGqfhftfqztNtqHtt
lMGZCGphllZDNshNNmHHND
PLwjVwJVsHmRrZZw
ffSdzjfZSjtjSjLtLLFFFGqFzznCpCnCBblQ
CqRnlzHCRWTlHPTZVQrcQtFsQFTcrQ
DfJcdBDBcftQjsrsBtjZ
JDfdGhSvNGhNfffGSfRznPvcRWcqCqmlvlcn
JPhBBBQCnCJCMhnhMZRrRZgbDgrWrNbglDgR
jLtSTwtsShwRNpRWrh
FLLSHsjGLGczvfPfJdfhddnHPC
BjHBNrWmTjFgJngbJhWd
vsGttMDtwCMQCJnqqqFJsggqdg
GFtDSwwMpTrzSSfcfm
rnWDQvpwWpDDcPjFPPHZjVDZ
CTJCRmCJcZZZHCCQ
LdlmdQJNpnLWbrfL
VdTdcVTZwCRGVGGMVmttlF
gnrsbngfgQSpBfpMBBBpSgMNNJbmGmlqGDqDNlFFJlGNFz
gprgQhgpMMMPsrRTCdPZwCwZZCRH
cHlCVGbbWHWqRNThhcNcmh
MwQDzpwdJwpBpPDQvrhShfLTTRLfLdjfNRqS
JwMBBrPsPDwQMDPPBPQJwMrvWHFbHHlgbsGnnWHnFnRGlblF
PQPjPDjRRQSFLSlgSmLlfh
zpLdBddbNCdqGbWJGWpJWWlsFsmmFpwfflFgfHwFhgmh
nJLdLVnzqqbjRctcPDQVTP
JdztScztPdSWLJLtgMbCjhvlbPRbjbMvCh
VZrqfQcFQwGVVFqfrTFTNqhljRHDMvMMGhRDRRHGbDhG
NZQNVQQpQmrZFQQFwQQVVZgBszJJgznstnmtcztdBSgs
nFHLNJzFbLJGGLMlTTRZbZRhWRTr
wVmgBBmtmwlqlWTwTM
sdvmgcPsCPPQQSMz
SccCqmQmgBmppLQmpSMjjlJzzsNPMDRbPNPlJM
VHZvwtZwhZHtdTwrVbNsljlRDlJPDhzsbN
dZwftVRftmcgpBCmBf
NTTlVlgNSflqbphFFhNbFp
wmmLmjwzwbWGLjRmtZZdhZLFtQQLQBFh
RvjbMjjvMzMWbDWwvzPjvmWSfVfsTlVVPVgTgPfVsnnnsJ
BsBsZHZNdWwsNdrzgCrMMqsjzzMC
flfhVWFmLrhQzCCh
fVbmFSpnSSmtnPZvdWbwvdvdHZ
NsZWWWWLsBZPhfsLmPhcFCCHCMMrqfqcvHMfHH
nThSllnplGlMpvFRcCqrrr
DnTwSztgzlDnVGTwztmdZhmLdJdNDshBdsWs
RBBGTFZGglMHvrtcgSdnNgjg
DmVcbmbJmwJDJzVVwzJfmfstnztvjnNjvNSpdptvzCnpjj
DsLcfLmbhVQssQJQscWRPBZZMMRLHFHZBGMG
FVvhVnhFnFhmvFhVcMBHLgcPClrqqrtqCppldrRRTppldg
QLWfDNwsQLtlrrCtDdpq
sJwZwLsGJWGGwzzWZNbWNLjQHSVhvHSnhcMFcbVmnvcchSBS
jTMNMrHBJWWDffRqfDBqfD
QmSFphtQqQmVmqVnPnPlpwgfnRnDPl
VqFmLFbLhmZhGFGmCmGtZLtJWzWHcJrNrHMccjMscMHzMZ
hGPGmbfPzbPfgdMdWGqBGQcqpp
nvFTvDrTdNZZlrjnMHHHpBBcppqq
rNlZZNLvRdRCRFFwZwhgbmSJPSmPfhfwhS
vjdbFWTtFRRvtvZZvdWJWbGjLhCcnrrrNqLNCPqchShNqc
QHQVlDsMfmmDMHDBdLdCSLnhNLNNfqCd
VQHsMDpHlzMBBwlsmMzmmlVwptvTWdvJdbvJtRTWgGFJJGtR
nSScBcnbbFSQVdBFBtWpwtvtPbTZthtTvT
pRzHpGjCDGzHGCGsThqqwZwPhCtvhTqZ
NzlzjDDpNldBFrlfFQ
qJlDlPPWppgppqPlplpfdvgnbMfGbdgCghMdCM
QWTWZcSsWbvVvTnhfC
tRFLwZrcrWzzlJmtBqlm
HMNMvvzzNcmfNmfbhs
qVcwCgjCLtWRSLsTPbmPfmTh
RtWCJgddWRtCJdWWgdBjwWWwpzMFpHGprcBGFFnGHQZHQGpF
gZgBDgDVGDGjmDZRtgjvVvtQdnLrcRcrdfdfCcnlscsJsn
WTqzqHqNzpHpwzNhMHNwWPbQCQcCLsnCrLLfcrffNflcNn
zHTwwpTPzTTwlFTFzwqzPbwZGgGZZBtmGGvGmBGZVFStFZ
znlSSzfzTcmmfcCt
PHWWGpqgPShPMwGwqJFTVtwtCVTCmTJcFc
qHqqSggLrRLBbvDDdndzRQ
WBddBQWZWWQqqQFMWfmrWsJnmVJJNDDVJGsLmHmLDN
PTgCjvCCPPPzSZGJVLsVZCHHnH
pzwtPTvzTjRTPtwSjPSzRgBbWMBfMwwZfbWrMrZFqFFM
BqDwVqdqlDlblQMf
ZcCWWcWzvJZjcPjZZZfTHfQJQHThqpMbQQJf
LPCcZcczZLgCjvPWgvstjsjmRRBdmGrdGdmSFGnFrtGmqr
CBvgQssVzfCBQSgvvvfmrlGrCtMGwthJlJtbrh
TpLqLRFpqdRpRTfNPtRmrMMtMlMMmlMJlt
PZTjqFFTHZZNZpqcVWzVvgzcWnSWfBDD
SVSTpgpVpdNbpcVdfjcNfbcJnqsltcJPvRJqRwQqlQsJls
zhWzDLmFHhmrWZmmzHJJQlnswqsvttrstQqs
zGtZFGGCmZmGGFhLBWBGGFdgVjgppMTSTgMfCNfVVSdj
CzjNJGcnzQJltPHttcPHTP
bLVsqLbLmSSVrqmdhVSmsVFFprfrFWrwTTWWWZpFPtlP
ssDsMqLqhvmvhdmdvzRCnQgRzzBjgnlNCM
TzTLzzSGRlRSjWzlWRzHGTpNhPhJPmdnNPPbhlbPbdhfPh
mBCDBVrCqVQvQMBcVcqBrBDsbtJfnZNbJndNNhthZNJfPZPs
wMCrqVvBzmzHTGLw
NbfwfZPPdVNPdBdQBcmQzrQz
nnWqHLWGFMDFDLDjsqnHLsrQGzmJczmQrgJmJGZmQrgJ
FFWRsHMHCZCWFwRwphpvlfTTpp
PclPlVZvLDNvVZSLSMvvDttmtfzFtzHqtqtzzccCFc
jrggQGhjQsTDbrbJjJQqzzCsdtzzFCdHqmBBHz
WGDgngwrQggZMNvMWPMRRV
wNgpMdMMcdSscccNcLLTbtQJtQJQltJwFtlBlzBt
HHGhrLrCvHWHCPhrWDtnBllnQbfQftGnfnBF
HvLjWCLHPZvHHHZjjrqVTTZVcppMgNNNNSpS
QQrwQmvWQjgTfvBjfffrSDcrqSqDDVLctqqcVd
GnHFnGhGplGMlHMNhzBzlLPLVcVNCPDqVNdcqLdqtV
GnMGpslMhGsRzzHzGsZFZQJTTmWfBbvfgfgJRfbwbW
MRCtSwMhvjCGtvMZDVWpVZJlVccNDlpb
gdLQFFwwLfHJWnQlcJJbWc
rdqdmqHLTLmsswsFHLFtMPRMCSSRtSjTPMPSCR
jmCCnLCLZjZjRjQTLZQhGPGhhzHhDRGRDzwzwh
stlJlrlJJcSSfSMMzPfhhGhzpwhpNwhD
rbrbBcSlWmdZWjDnTm
PNBRNnnqQRNfVfRtVVzgFLLttpSwgzzzmFFF
fcWlcbvvCFzLbwLw
rlrMrhTJhDcTTfhRNqHRQPQRQNQB
TrprpprRVVfpRpVqTVpzDdvmvbbCchhcttqcthSMdd
JlnZnFlsMBZnJHlsLsCLbSNtbNhdbbShCScm
FlZjjsHHsnQFQwTDzMRRpGRR
wHWzwCTTqJhzzvJhWHWhqJWrFsFQrrrFCfFfgjjgjprfsp
DBRmZRtZLbnRBGSBmtGSLpjBrrsfrgsTQVrVrrPrgr
DLnbcbtLtmNNmbRcGbcGmHzlThNNhqJTHdvqvWlHJh
GSNqjRcqflNLnCTTWrWn
BmwQtmtJwPwmzMwQtHtVssvrnpWTTnsTTgpVCLCs
DBBQHJJrzhzQDDfSljRfhccfcdZf
wtgtChCwzqgLzjggqtHtjFHHFcnPfdRDfZZVcPfVZZfGnfdm
vBTrRTTWGGmcTDVD
SJMbbpWslJblSSNzNsztRChzqRCj
gBHHCtVCSHMQlfFTQqCfmq
WrpdwjbwbwQGlPqSqblP
wWDncWrDDNdWNRjScScjpzvHZtBMZtJsvLVgvzssBsvs
VppWpVfmZPBlnmrGBzhttMzMpctLLcChSh
FwgLJvRdHcwMzSzjzc
QvbgdQLQgDvsqvqRHRDdDQDBWmBGBflnVbZmZmmnBBWrmW
SqShwLFCQGpDHCtZCWpW
bdHPHjTbJdsMnPHPbdjgtnBlVlBnVgtZpDBpWV
bdmPcjbjMNMvvHbTcQRNfRwRwLffwwqwNF
zdRHTpQTQHQnpnnQRHTsNNlJSJWmzJmJllNmSG
FBbRvLbFRwLqbbVgBVqqLFqJtJNcltsSGmgmGtNtgWmstm
FLhhfvvVwvjqfLRBqLVqbwqZQrTTpHMHjdrpnnDPDQCdCrpC
JgjzvbJCWgbjgGbJWjRhgNPGHHBMtqBStZZsHMSsBqtD
cfQdwQFdQQppnVVnlFLLBsBZMhqPlPMMqBSHDtHM
wnQhcnVddmdWgjvjmvRjjJ
QpcRtndvsLcVJtRSzWSlWjzSbjjWBv
qGZPqCTmGPqgGTCqHgCqZCPFWbbBNBMNBbdBMlWWrbjlMbFl
qhHDGhCmPhZHgDmDVQthttRchLwLdwcc
srpPMwlMmsrGFGswvDRhRWRDJJJchJ
fSgBbCBNnBTTgCNLTCRJhRJVWhTcVVVFFJdR
SbBnnLNZCLFQCZjnCnZFjPrzqmlMmmsrpzrlsmtt
BBsfDfsBDSWRwlLqmWCpWcllrl
nQMgMnnnhdntgMBrCdpNNLNlNqLqLl
FnQFHzPQJjJGRBGvfR
lRnVRFFlgMCRVwLgFZRnZQHWdcftHdmcJHmmMdzzfz
DGBqGQbhhBDbSBpGDBzqdNHJdtmcWdqdmtcm
bjbsBvjhSlVsPRgLQl
dDLbRdTMRJMbFRzZBfzNSjtNBzBD
PmgspqqVrppTVrvrsPhhfQwZBwNjNtNffzqqfwwN
mCcmsngrPvpVTssCVsvsPLRRJllGFlnRGbMJMWWlJJ
fGlGZHRRbwgPbZRRNCdcSWpncnQtQWlWcWpW
JrTLJgVvVLQQvtSvQncQ
JrrrmMTBVTmjBMrVjrshmJzgCfzRPCRZPGHfbwNPzbZHNH
qqqlDDZzVVnNqHDDFFFNlQpzjrTvsvzTbgJQQggjJp
cWPWcCmMfCMWdtPMhMbQQQjGGjpdvjTbjgjr
WtMSBCtCwchChMfBWtcPnNVNqZZLDRNqTRnnlwHn
mvQQnhBvhmvBmncmZBclTZTQccRFNFFdqFFgVqSRrgFrppNR
MjzJPzGPfffMCjVVjfPHLCFRNFStqrdRSdqdNGRqNptq
HDJHPjDJLfjbzfwPjCzCWWTwlmQhBnsWBvVsvBvZ
RVjcshhscQhrVjhvzjVfDNnzGtftmDHFttFGGf
qLcBCCMBJJbTdBDnNtdfnmDG
WpZgLLclTclRwgjgsrwsvj
shhhltNPcDtlNcNMcsctNtppLZvWWFLTFFZpTZDQgFLT
dRgJVzRHbqnLpTWQvLLJfp
mCVCdzqHndbqHCrVqRrmbwtNBsmPwNmScPgtPhBclw
bDDZMDrFPsrsMcsrbJZJdMMGpSzpSbwRSSRGpCHCGzlhCC
BWWNQjBLQVHhlGpSCmwj
ffwnNwfgtnNgVVwfNWBWnFsMJTJTcPFJcTFDsrJstJ
vQbQLQBpBvbvpHplHNTHWGZDngntZCQGgZhGhtjG
rqccPPmcrffRmsmCjVgnrGChChDjgW
fqRJsJMSlSzSWTbT
brsjjJPJwrJJsrRRlllNQGWQpwppCtfGGtWzGGMQ
ncBqqLTDnmLgVDZVnBDmdtVVtMzWWdMCQdpQWdVz
hDZgTSSnTzNPNFSFPF
VZVJJtWTsfTVVWsJhPWrCjzSBJlHSmjJCRlNSSlz
CqMpwccgvvgLnvLbMMRRjBNHzjmGmwNHlmlN
gLqqvpCDfVDrTfVW
CNMDGNPPNJCGbLnTffsTLT
tcBBRlrBdQrtmtWFjjbnrTjjFbjr
cTQQhcmvcBRcwDMVDZZPPCJh
mBCdgPLgZmLfGmfvGhtRQJWjtjQGQhtN
pMwrVwbwHMsqcTWQhQWzggTTWp
nnSMwrlrsmSZgvvmDd
WNSzpCzNzqzNdmqrRHrrLHFrJH
MtPfvnGMPnMcbnRtDHTRFFDrmJRQ
PcBsfPPHPGGfcSzZjNjpNZZdCs
mDCZVLDhWVSDCRvGtsGgGRHl
JjPwPNdcPnjPdcwNltHzzGmgGJzQJJRQ
dqfjnNmwmbmWrZMbMrThhB
qtBpNZFpBGFNfZNPmZPmQmHrmPPPTz
LLwJLvDvlWWLHdwDrVcCRcDVzzVVcV
sMMwvgjnMvjvnlsvNFBqfGHFqHGjtSpS
MmZZsFgwJTdTMdgmZdZRgFhDHhPQPPnRPhCrHhnnrPDD
fBcLlNNpQCDLDJJC
jSbWWlWpBpclWlWpNWlVBbWVdgwswFJmFJsGtdMggZFGbZwd
CMVQVMLLMFGRCMWQttnqqwQwhqsm
pJzlczSpPpPgmsqNhmPGDstq
gZgTccZGGpzdpjclGRVMVRFRMFvHRLRdLf
FMWMSBtStZqZWQtFtScWWSZmHPVJJVHwwlTgmgbzQwbwTJ
jhGLhdjNjsLvLsshzHJPVdVmmbzHzdHJ
jvDRNjnDNGRCzjLzZZpqnrFBSccWrMcB
zggmthDDghHvtrdgrVWfSBRwTHLWHwsBWw
PGGjpCjQnJQGJcJnnQpjFWVSsZWVLRZLBcsWSZBRWS
FGQlpnJCbqqGGRCjjnlCqGMtdNmmmvdNmmmzvhbrmgMz
TstvBTdgBhqTsdTcPlfCSrNMrNnrCNNSNNgp
HwLQwQDZzDjnDbmMhNSnmm
FZLVzLLQHRRzwWHjdPlJctlJtlsllhRs
fBtPsMDDswHvBmmVdBlSBRcGGnhVhg
LWJbrpFqpTLTTjqqNWlhnRGGSnhrcSdlRlsh
JWNbbpjJzTbNNNJNJMvmvfZHvzDsHDCsZw
LPGnPNLtwGhFFnJPfsqpVVszzpsP
TcWdvlrcWddggrDBDDdDMmWzRJqfVQZqmsfZsRQzZfZzQJ
TldWrMrDdlDCDdMTcwSLVCSShLNSwHjhGF
JGsWWWQsJmPwQWbBPmccbcbqFfMMpFDVCDFVFVCDqqfFwD
ZtLnlvLnNtvLndnCmfMVSmVCClfpVp
zTzZtjnZNLNmZvdtznntHHZJbBRGBRQWcJGbGsbsJRPQWT
MLmlMTPtQtMNlhbqbbqhflBB
rcrvjpSvScbRbBvbDBPG
ZZJzSHpzPrJzHFmMVMFmHCLNtV''';
