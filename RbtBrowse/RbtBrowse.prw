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
	
	Data FieldsGrid
	Data Itens
	Data Titulo
	Data UseTempTable
	Data TableObj
	Data AdjustedFields 
	Data AliasX3
	Data Colunas
	Data Query
	Data MarkColumn
	Data Indices
	Data CreateIndices
	
	
	
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
		AdjustedFields  := .F.
		::Colunas := {}
		::CreateIndices := .T.
return


method SetFreeze(nCol) class RbtBrowse

::oBrowse:nFreeze := nCol
::SetLineHeight(::nRowHeight)
::Refresh(.t.)



return


method  CreateTemp() class RbtBrowse
	Local cQuery := ""
    Local _nI,i,_nY
	::TableObj := FWTemporaryTable():New()
    
    IF !::AdjustedFields 
    	::AdjustAFields()
    ENDIF
        
    aFields := {}

    FOR _nI := 1 TO Len(::FieldsGrid)
    	 aAdd(aFields, {::FieldsGrid[_nI][1],;
    	  			    ::FieldsGrid[_nI][6],;
    	  			    ::FieldsGrid[_nI][3],;
    	  			    ::FieldsGrid[_nI][4]})
    	  			   
    	 
    Next _nI

    ::TableObj:SetFields(aFields)
    
    IF ::CreateIndices 
    
        IF ::Indices <> NIL
            FOR _nI := 1 TO Len(::Indices)
                
                            
                ::TableObj:AddIndex(StrZero(_nI,2), {::Indices[_nI]} )
            Next _nI
        ELSE

            FOR _nI := 1 TO Len(::FieldsGrid)
                
                            
                ::TableObj:AddIndex(StrZero(_nI,2), {::FieldsGrid[_nI][1]} )
            Next _nI
            
        ENDIF
    ELSE
    
    ENDIF
   
   
    ::TableObj:Create()
    ::AliasX3 := ::TableObj:GetAlias()


    IF ::Query <> nil
    	
    	 cTableName := ::TableObj:GetRealName()
    	  
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
    	 MemoWrite( "\RbtBrwQuery.TXT", cQuery )
    	 if TCSqlExec(cQuery) < 0
    	 	ConOut("ErroSql:", TCSqlError())
    	 endif
    	 
    ENDIF
    
    IF ::Itens <> NIL

	    For _nI := 1 To Len(::Itens)
	    	RecLock((::AliasX3),.T.)
	    		For _nY := 1 To Len(::FieldsGrid)
	    			cFlName := ::FieldsGrid[_nY][1]
	    			cValA	:= ::Itens[_nI][_nY]
                    cTpField := ::FieldsGrid[_nY][6]
                    IF cTpField == "D"
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  stod(cValA) ")
                    ELSE
                        &(" "+ ::AliasX3 + "->"+ cFlName+" :=  cValA ")
                    ENDIF
				   
			    Next _nY
			 MsUnlock()
	    Next _nI
	ENDIF   
	
	
	
	
	    
Return


Method CreateMark() Class RbtBrowse

	IF ::MarkColumn <> NIL
		
        ::AddMarkColumns({||IIf(&(""+(::AliasX3)+"->"+(::MarkColumn)+""),'LBOK','LBNO')},;
            {|| IIF(&(""+(::AliasX3)+"->"+(::MarkColumn)+""),&(""+(::AliasX3)+"->"+(::MarkColumn)+" := .F. "),;
            &(""+(::AliasX3)+"->"+(::MarkColumn)+" := .T. ") ) },;
            {|| &("DBEVAL({|| IIF("+::AliasX3+"->"+::MarkColumn+","+;
            " "+::AliasX3+"->"+::MarkColumn+" := .F., "+::AliasX3+"->"+::MarkColumn+" := .T.)})"),::GoTop()})
    
	ENDIF

Return





METHOD GetColumnTotal(cColumn)  Class RbtBrowse

	Local aAreaB := (::AliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::AliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += "+::AliasX3+"->"+cColumn+" })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot


METHOD GetRowsCount()  Class RbtBrowse

	Local aAreaB := (::AliasX3)->(GetArea())
	private nTot := 0
	
	dbSelectArea(::AliasX3)
	dbGoTop()
	bEval := "DBEVAL({|| nTot += 1 })"
	&(bEval)
	
	RestArea(aAreaB)


Return nTot


method AdjustAFields() Class RbtBrowse

Local _nI

IF ::FieldsGrid == NIL 
	::FieldsGrid := {}
ENDIF

IF LEN(::FieldsGrid) == 0
	IF ::AliasX3 == NIL
		Alert("Campos ou Alias não preenchido!")
		RETURN
	ELSE
		aFieldSx3 := FWSX3Util():GetAllFields(::AliasX3, .F. )
		FOR _nI  := 1 TO Len(aFieldSx3)
			aAdd(::FieldsGrid,{aFieldSx3[_nI],;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TITULO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TAMANHO"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_DECIMAL"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_PICTURE"),;
				                GetSx3Cache(aFieldSx3[_nI],"X3_TIPO");				                
				                })
		Next _nI
	ENDIF
	
ELSE
	
    For _nI := 1 To Len(::FieldsGrid)
		IF LEN(::FieldsGrid[_nI]) == 1
			::FieldsGrid[_nI] := {::FieldsGrid[_nI][1],;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TITULO"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TAMANHO"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_DECIMAL"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_PICTURE"),;
								   GetSx3Cache(::FieldsGrid[_nI][1],"X3_TIPO");	
			 					   }
		ENDIF

	
	
	Next _nI
ENDIF

::AdjustedFields := .T.

return



method  CreateBrw() class RbtBrowse

Local nI := 1

IF !::AdjustedFields 
    	::AdjustAFields()
ENDIF

IF ::UseTempTable

	::CreateTemp()

ENDIF
nCol := 1
For nI := 1 To Len(::FieldsGrid)
	lAddCol := .T.
	
	IF VALTYPE(::FieldsGrid[nI][LEN(::FieldsGrid[nI])]) == "L"
		IF ::FieldsGrid[nI][LEN(::FieldsGrid[nI])]
			lAddCol := .T.
		ELSE
			lAddCol := .F.
		ENDIF
	ELSE	
		lAddCol := .T.
	
	ENDIF
	IF lAddCol
		aAdd(::Colunas,FWBrwColumn():New())
		::Colunas[nCol]:SetData(&("{||"+::AliasX3+"->"+::FieldsGrid[nI][1]+"}"))
		::Colunas[nCol]:SetTitle(::FieldsGrid[nI][2])
		::Colunas[nCol]:SetSize(::FieldsGrid[nI][3])
		::Colunas[nCol]:SetDecimal(::FieldsGrid[nI][4])
		::Colunas[nCol]:SetPicture(::FieldsGrid[nI][5])
        nCol++
	ENDIF
Next nI

return

method Create(oParent) class RbtBrowse
    
    ::CreateBrw()
    ::setDescription(::Titulo)
    ::setDataQuery(.F.)
    ::CreateMark()
    ::setColumns(::Colunas)
    ::setDataTable(.T.)
    ::setAlias(::AliasX3)
    ::setUseFilter()
    ::setOwner(oParent)    
 
Return


Method Destroy() class RbtBrowse
	IF ::UseTempTable
		::TableObj:Delete()
	ENDIF
Return



