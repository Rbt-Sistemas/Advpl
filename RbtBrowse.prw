#include 'protheus.ch'
#DEFINE  ENTER CHR(13)+CHR(10) 

/*/{Protheus.doc} RbtBrowse
(long_description)
@author    Roberto Alves
@since     13/03/2020
@version   1.0.1
@example
(examples)
@see (links_or_references)
/*/
class RbtBrowse FROM FWBrowse
	
	Data aFieldsGrid
	Data aItens
	Data cTitulo
	Data lTempTable
	Data oTable
	Data lAdjustedFields 
	Data cAliasX3
	Data aColunas
	Data Query
	Data aMarkColumns
	Data aIndices
	Data lIndices
	
	
	
	method New() constructor 
	method Create(oParent)
	method CreateBrw()
	method CreateTemp()
	method AdjustAFields()
	method Destroy()
	method GetColumnTotal(cColumn)
	method CreateMark()
	method GetRowsCount()
	method SetFreeze(nFreeze)

endclass


method New() class RbtBrowse
		_Super:New()
		lAdjustedFields  := .F.
		::aColunas := {}
		::lIndices := .T.
return


method SetFreeze(nCol) class RbtBrowse

::oBrowse:nFreeze := nCol
::SetLineHeight(::nRowHeight)
::Refresh(.t.)



return


method  CreateTemp() class RbtBrowse
	Local cQuery := ""
    Local _nI,i,_nY
	::oTable := FWTemporaryTable():New()
    
    IF !::lAdjustedFields 
    	::AdjustAFields()
    ENDIF
        
    aFields := {}

    FOR _nI := 1 TO Len(::aFieldsGrid)
    	 aAdd(aFields, {::aFieldsGrid[_nI][1],;
    	  			    ::aFieldsGrid[_nI][6],;
    	  			    ::aFieldsGrid[_nI][3],;
    	  			    ::aFieldsGrid[_nI][4]})
    	  			   
    	 
    Next _nI

    ::oTable:SetFields(aFields)
    
    IF ::lIndices 
    
        IF ::aIndices <> NIL
            FOR _nI := 1 TO Len(::aIndices)
                
                            
                ::oTable:AddIndex(StrZero(_nI,2), {::aIndices[_nI]} )
            Next _nI
        ELSE

            FOR _nI := 1 TO Len(::aFieldsGrid)
                
                            
                ::oTable:AddIndex(StrZero(_nI,2), {::aFieldsGrid[_nI][1]} )
            Next _nI
            
        ENDIF
    ELSE
    
    ENDIF
   
   
    ::oTable:Create()
    ::cAliasX3 := ::oTable:GetAlias()


    IF ::Query <> nil
    	
    	 cTableName := ::oTable:GetRealName()
    	  
    	  if TCIsConnected()
    	  	nConnect := TCGetConn()
    	  	lCloseConnect := .F.
    	  else
    	  	nConnect := TCLink()
    	  	lCloseConnect := .T.
    	  endif
    	 
    	 cFieldsSql := "("
    	 For i := 1 to Len(aFields)
    	 		cFieldsSql += aFields[i][1]
    	 		if i < Len(aFields)
    	 			cFieldsSql += ","
    	 		endif
    	 Next i
    	 cFieldsSql += ")"
    	 cQuery :=   "INSERT INTO " + cTableName +  " " + cFieldsSql +ENTER+"	"+ ::Query 
    	 CONOUT(cQuery)
    	 MemoWrite( "\logfontes\RbtBrwQuery.TXT", cQuery )
    	 if TCSqlExec(cQuery) < 0
    	 	ConOut("Ops:", TCSqlError())
    	 endif
    	 
    ENDIF
    
    IF ::aItens <> NIL

	    For _nI := 1 To Len(::aItens)
	    	RecLock((::cAliasX3),.T.)
	    		For _nY := 1 To Len(::aFieldsGrid)
	    			cFlName := ::aFieldsGrid[_nY][1]
	    			cValA	:= ::aItens[_nI][_nY]
                    cTpField := ::aFieldsGrid[_nY][6]
                    IF cTpField == "D"
                        &(" "+ ::cAliasX3 + "->"+ cFlName+" :=  stod(cValA) ")
                    ELSE
                        &(" "+ ::cAliasX3 + "->"+ cFlName+" :=  cValA ")
                    ENDIF
				   
			    Next _nY
			 MsUnlock()
	    Next _nI
	ENDIF   
	
	
	
	
	    
Return


Method CreateMark() Class RbtBrowse

	IF ::aMarkColumns <> NIL
		
        ::AddMarkColumns({||IIf(&(""+(::cAliasX3)+"->"+(::aMarkColumns)+""),'LBOK','LBNO')},;
            {|| IIF(&(""+(::cAliasX3)+"->"+(::aMarkColumns)+""),&(""+(::cAliasX3)+"->"+(::aMarkColumns)+" := .F. "),;
            &(""+(::cAliasX3)+"->"+(::aMarkColumns)+" := .T. ") ) },;
            {|| &("DBEVAL({|| IIF("+::cAliasX3+"->"+::aMarkColumns+","+;
            " "+::cAliasX3+"->"+::aMarkColumns+" := .F., "+::cAliasX3+"->"+::aMarkColumns+" := .T.)})"),::GoTop()})
    
	ENDIF

Return





METHOD GetColumnTotal(cColumn)  Class RbtBrowse

	Local aAreaB := (::cAliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::cAliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += "+::cAliasX3+"->"+cColumn+" })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot


METHOD GetRowsCount()  Class RbtBrowse

	Local aAreaB := (::cAliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::cAliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += 1 })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot


method AdjustAFields() Class RbtBrowse

Local _nI

IF ::aFieldsGrid == NIL 
	::aFieldsGrid := {}
ENDIF

IF LEN(::aFieldsGrid) == 0
	IF ::cAliasX3 == NIL
		Alert("Campos ou Alias não preenchido!")
		RETURN
	ELSE
		aFieldSx3 := FWSX3Util():GetAllFields(::cAliasX3, .F. )
		FOR _nI  := 1 TO Len(aFieldSx3)
			aAdd(::aFieldsGrid,{aFieldSx3[_nI],;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TITULO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TAMANHO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_DECIMAL"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_PICTURE"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TIPO");				                
				                })
		Next _nI
	ENDIF
	
ELSE
	
    For _nI := 1 To Len(::aFieldsGrid)
		IF LEN(::aFieldsGrid[_nI]) == 1
			::aFieldsGrid[_nI] := {::aFieldsGrid[_nI][1],;
								   GetSx3Cache(::aFieldsGrid[_nI][1],"X3_TITULO"),;
								   GetSx3Cache(::aFieldsGrid[_nI][1],"X3_TAMANHO"),;
								   GetSx3Cache(::aFieldsGrid[_nI][1],"X3_DECIMAL"),;
								   GetSx3Cache(::aFieldsGrid[_nI][1],"X3_PICTURE"),;
								   GetSx3Cache(::aFieldsGrid[_nI][1],"X3_TIPO");	
			 					   }
		ENDIF

	
	
	Next _nI
ENDIF

::lAdjustedFields := .T.

return



method  CreateBrw() class RbtBrowse

Local nI := 1

IF !::lAdjustedFields 
    	::AdjustAFields()
ENDIF

IF ::lTempTable

	::CreateTemp()

ENDIF
nCol := 1
For nI := 1 To Len(::aFieldsGrid)
	lAddCol := .T.
	
	IF VALTYPE(::aFieldsGrid[nI][LEN(::aFieldsGrid[nI])]) == "L"
		IF ::aFieldsGrid[nI][LEN(::aFieldsGrid[nI])]
			lAddCol := .T.
		ELSE
			lAddCol := .F.
		ENDIF
	ELSE	
		lAddCol := .T.
	
	ENDIF
	IF lAddCol
		aAdd(::aColunas,FWBrwColumn():New())
		::aColunas[nCol]:SetData(&("{||"+::cAliasX3+"->"+::aFieldsGrid[nI][1]+"}"))
		::aColunas[nCol]:SetTitle(::aFieldsGrid[nI][2])
		::aColunas[nCol]:SetSize(::aFieldsGrid[nI][3])
		::aColunas[nCol]:SetDecimal(::aFieldsGrid[nI][4])
		::aColunas[nCol]:SetPicture(::aFieldsGrid[nI][5])
	//	::aColunas[nCol]:SetEdit(.T.)
     //   ::aColunas[nCol]:SetReadVar("M->"+::aFieldsGrid[nI][1])
        nCol++
	ENDIF
Next nI

return

method Create(oParent) class RbtBrowse


    
    ::CreateBrw()

    ::setDescription(::cTitulo)
    //::SetTemporary(.T.)
    ::setDataQuery(.F.)
    ::CreateMark()
    ::setColumns(::aColunas)

    ::setDataTable(.T.)
    ::setAlias(::cAliasX3)
    ::setUseFilter()
    ::setOwner(oParent)    
    
 
Return


Method Destroy() class RbtBrowse
	IF ::lTempTable
		::oTable:Delete()
	ENDIF
Return



