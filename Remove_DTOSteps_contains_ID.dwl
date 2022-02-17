%dw 2.0
output application/xml

fun FNtransformCoverage(x, index)=
    x match {
      case is Object -> x mapObject 
        if ($$ as String == "DTOCoverage" )
            { 
                DTOCoverage @(( $$.@ )): $ - "DTOSteps"

            }
        else 
            (($$): FNtransformCoverage($, index+1)) 
      else -> $
    }
    
---
FNtransformCoverage(payload,1)
