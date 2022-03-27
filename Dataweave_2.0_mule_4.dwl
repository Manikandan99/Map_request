%dw 2.0
output application/java
---
{
	Pkg: {
		Premium: {
			LiabSizeCr: vars.liabSizeCr default 0,
			LiabACP: vars.liabACF default 0,
			PropACP: vars.propACF default 0,
			ManualLiab: vars.manualLiab default 0,
			ManualProp: vars.manualProp default 0,
			FinalLiabPrem: vars.finalLiabPrem default 0,
			FinalPropPrem: vars.finalPropPrem default 0
		}
	},
	GW: {
		Factors: {
			LossExp: if(payload.DTOApplication.DTOTOPADRCAttributes.@PolicyLossExpFactor != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyLossExpFactor) else "" default "",
			AccChar: if (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyAccountCharacter != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyAccountCharacter) else "" default "",
			PackageLiabDisc: if (payload.DTOApplication.DTOTOPADRCAttributes.@LiabPackDiscFactor != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@LiabPackDiscFactor) else "" default "",
			PackagePropDisc: if (payload.DTOApplication.DTOTOPADRCAttributes.@PropPackDiscFactor != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@PropPackDiscFactor) else "" default "",
			MultiPolDisc:  if (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyMultiDiscFactor != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyMultiDiscFactor) else "" default "",
			IRPM: if (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyIRPMFactor != "0") (payload.DTOApplication.DTOTOPADRCAttributes.@PolicyIRPMFactor) else "" default ""
		}
	},
	Policy: {
		LOBBundle: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyType default "",
		Industry: payload.DTOApplication.*DTOBasicPolicy[0].@PolicyGLClassIndustry default "",
		ZipCode: payload..Addr[?($.@AddrTypeCd == "InsuredPrimaryBusAddr")][0].@PostalCode[0 to 4] default "",
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
		NumLocInsp: payload.DTOApplication.*DTOBasicPolicy[0].@InspectionLocations default ""
	}	
}
