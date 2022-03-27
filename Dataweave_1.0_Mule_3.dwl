%dw 1.0
%output application/java
---
{
	Pkg: {
		Premium: {
			LiabSizeCr: flowVars.liabSizeCr default 0,
			LiabACP: flowVars.liabACF default 0,
			PropACP: flowVars.propACF default 0,
			ManualLiab: flowVars.manualLiab default 0,
			ManualProp: flowVars.manualProp default 0,
			FinalLiabPrem: flowVars.finalLiabPrem default 0,
			FinalPropPrem: flowVars.finalPropPrem default 0
		}
	},
	GW: {
		Factors: {
			LossExp: payload.DTOApplication.DTOTOPADRCAttributes.@PolicyLossExpFactor when payload.DTOApplication.DTOTOPADRCAttributes.@PolicyLossExpFactor != "0" otherwise "" default "",
			AccChar: payload.DTOApplication.DTOTOPADRCAttributes.@PolicyAccountCharacter when payload.DTOApplication.DTOTOPADRCAttributes.@PolicyAccountCharacter != "0" otherwise "" default "",
			PackageLiabDisc: payload.DTOApplication.DTOTOPADRCAttributes.@LiabPackDiscFactor when payload.DTOApplication.DTOTOPADRCAttributes.@LiabPackDiscFactor != "0" otherwise "" default "",
			PackagePropDisc: payload.DTOApplication.DTOTOPADRCAttributes.@PropPackDiscFactor when payload.DTOApplication.DTOTOPADRCAttributes.@PropPackDiscFactor != "0" otherwise "" default "",
			MultiPolDisc: payload.DTOApplication.DTOTOPADRCAttributes.@PolicyMultiDiscFactor when payload.DTOApplication.DTOTOPADRCAttributes.@PolicyMultiDiscFactor != "0" otherwise "" default "",
			IRPM: payload.DTOApplication.DTOTOPADRCAttributes.@PolicyIRPMFactor when payload.DTOApplication.DTOTOPADRCAttributes.@PolicyIRPMFactor != "0" otherwise "" default ""
		}
	},
	Policy: {
		LOBBundle: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyType default "",
		Industry: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyGLClassIndustry default "",
		ZipCode: payload..Addr[?($.@AddrTypeCd == "InsuredPrimaryBusAddr")][0].@PostalCode[0..4] default "",
		QualPremCommAuto: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1110B")][0].@Value default "",
		QualPremWC: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1110D")][0].@Value default "",
		QualPremCommXS: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1110F")][0].@Value default "",
		TerrorismInd: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@TRIA default "",
		IRPM: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@PropertyScheduledPremiumMod default "",
		IRRSBldg: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorBldg default "1",
		IRRSBPP: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorBPP default "1",
		IRRSBIEE: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorBIEE default "1",
		IRRSTheft: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorTheft default "1",
		IRRSEqBrkdn: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorEQBreakDown default "1",
		IRRSLiab: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorLiability default "1",
		IRRSAssBatLtd: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorAssault default "1",
		IRRSCyber: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorCyber default "1",
		IRRSEPLI: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorEPLI default "1",
		IRRSLiqLiab: payload.DTOApplication.*DTOLine[?($.@StatusCd == "Active" and $.@LineCd == "CommercialProperty")][0].@IRRSFactorLiqLiability default "1",
		EffDate: payload.DTOApplication.*DTOBasicPolicy[0].@EffectiveDt default "",	
		BusEstDate: payload.DTOApplication.*DTOBasicPolicy[0].@BusinessEstDt default "",
		ACSecSurv: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1235")][0].@Value default "",
		ACPets: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1150")][0].@Value default "",
		ACHour: payload.DTOApplication.QuestionReplies.*QuestionReply[?($.@Name == "1100")][0].@Value default "",
		ACPlumbing: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyPlumbingYear default "",
		ACRoofing: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyRoofingYear default "",
		ACWiring: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyWiringYear default "",
		NumLocInsp: payload.DTOApplication.*DTOBasicPolicy[0].@InspectionLocations default "",
		(
			payload.DTOApplication.*DTOLossHistory[?($.@StatusCd == "Active")] default [] orderBy -($.@LossDt) map using (dispIdx = zeroPad2($$+1)) {
				'CauseOfLoss$dispIdx': $.@LossCauseCd,
				'DateOfLoss$dispIdx': $.@LossDt,
				'IncurredAmt$dispIdx': $.@TotalIncurred
			}				
		)
	}	
}
