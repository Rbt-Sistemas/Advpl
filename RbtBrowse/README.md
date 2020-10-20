<br />

<p align="center">
  <a href="https://github.com/Rbt-Sistemas/Advpl">
    <img src="https://github.com/Rbt-Sistemas/Advpl/blob/master/RbtBrowse/Logo.png?raw=true" alt="Logo>
  </a>
</p>
</br>
<p align="center">												 
  <h3 align="center">Advpl - RbtBrowse</h3>	
  <p align="center">	
    Classe para criação de tabela herdada da FwBrowse
    <br/>	
    <a href="https://github.com/Rbt-Sistemas/Advpl/issues">Solicitar uma Feature</a>	
  </p>	
</p>

## RbtBrowse
* [Hierarquia](https://tdn.totvs.com/display/public/PROT/FwBrowse)	
  * [FwBrowse](https://tdn.totvs.com/display/public/PROT/FwBrowse)	
* [Sobre](#sobre)	
* [Classe](#classe)	  
  * [Construtores](#construtores)	
    * [RbtBrowse:New()](#new)	
  * [Instalação](#instalação)	
* [Roadmap](#roadmap)	
* [Contribuindo com o projeto](#contribuindo-com-o-projeto)	
* [Material de Apoio](#material-de-apoio)	

## Sobre  

**Exemplo RbtBrowse:**

![screenshot](https://github.com/Rbt-Sistemas/Advpl/blob/master/RbtBrowse/example.png?raw=true)	

## Classe	 <h3>RbtBrowse <small class="text-muted">class</small>
  ### Definição
  <p class="lead">
      Class to create FwTemporaryTable/FwBrowse from FwBrowse with many
      features.
  </p>
  <h3>RbtBrowse <small class="text-muted">class</small>
   Class to create FwTemporaryTable/FwBrowse from FwBrowse with many
   features.
   
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
#### Exemplo
  
  ```clipper

      Local aItems := {}
      Local aFields := {}// Add a column especifiedaAdd(aFields,{SELECOL',;
      // Name of col markup.
      Sel,; //Title
      1,;//Size
      0,;//Decimal
      ,;//Picture
      L,;//Type
      .F.}) //Visible (If .F. Create colunm in only FwTemporaryTable
      // then dont diplay in FwBrowse)//Add Col from SX3aAdd(aFields,{B1_COD})
      aAdd(aFields,{B1_DESC})//Add a column especified
      DescaAdd(aFields,{'DESCRICAO',; // Name of col markup.
      Desc,; //Title
      9,;//Size
      0,;//Decimal
      @!,;//Picture
      C,;//Type
      .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable//
      // then dont diplay in FwBrowse)//Add a column especified
      VaLOR// aAdd(aFields,{VALOR',; // Name of col vlor.
      Valor,; //Title
      12,;//Size
      2,;//Decimal
      @!,;//Picture
      N,;//Type
      .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable//
      // then dont diplay in FwBrowse)//Add items from array at
      finish, in order of columns and add a logical in finish (Deleted)
      aAdd(aItems,{.T.,CODIGO001,DESC COD 01,POR ITEM,15.20,.F.})
      aAdd(aItems,{.T.,CODIGO002,DESC COD 02,POR ITEM2,10.50,.F.})
      oBrowse := RbtBrowse():New()
      oBrowse:UseTempTable := .T.
      oBrowse:CreateIndexs := .T.
      oBrowse:MarkColumn := SELECOL
      oBrowse:FieldsGrid := aFields
      oBrowse:Items := aItems// //Add items from query dont need
      deleted default .F.
      oBrowse:Query := SELECT TOP 100 'F' AS SELECOL,B1_COD,B1_DESC,'EXEMPLO'
      AS DESCRICAO, 0.00 AS VALOR +;
      FROM +RETSQLNAME(SB1)+ WHERE D_E_L_E_T_&lt;&gt;'*'
      oBrowse:Title := Titulo Browse
      oBrowse:Create(oDlg)// //Num rowsoBtn1:bAction := {||
      MsgAlert(cValToChar(oBrowse:GetRowsCount()),Linhas!) }
      //Sum of coloBtn2:bAction := {||
      MsgAlert(cValToChar(oBrowse:GetColumnTotal(VALOR)),Total)}
      oBrowse:Activate()
      ACTIVATE MSDIALOG oDlg CENTERED
      Return    
  ```
  
  #### Veja também
 <a href="https://www.rbtsistemas.com/utils/advpl/" target="_blank">Rbt Sistemas</a>

  ### New <small class="text-muted">method</small>
	Construtor da classe
  #### Autor
    Roberto Alves
  #### Desde
    13/03/2020
  #### Versão
    1.3.0
  #### Exemplo
  
  #### Retorno
	
<table class="table table-striped table-bordered table-hover table-condensed">
<thead>
<tr>
<th>Tipo</th>
<th>Descrição</th>
</tr>
</thead>
<tbody>
<tr>
<td>object</td>
<td>RbtBrowse</td>
</tr>
</tbody>
</table>

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

### SetFreeze <small class="text-muted">method</small>
     
<hr />
<p class="lead">
Index of col to freeze, just 1 by limitation of framework
</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0



<div class="table-responsive">
<h4>Parâmetros</h4>
<table class="table table-striped table-bordered table-hover table-condensed">
  <thead>
    <tr>
      <th>Nome</th>
      <th>Tipo</th>
      <th>Uso</th>
      <th>Descrição</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>nCol</td>
      <td>numeric</td>
      <td>false</td>
      <td>Col Index to be freeze</td>
    </tr>
  </tbody>
</table>
</div>


#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

### CreateTemp <small class="text-muted">method</small>

<hr />
<p class="lead">Create a FwTemporaryTable by FieldsGrid property</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
#### Exemplo
   
#### Outras Informações

<table class="table table-striped table-bordered table-hover table-condensed">
  <tbody>
    <tr>
      <td>obs</td>
      <td>Need FieldsGrid property previous setted</td>
    </tr>
  </tbody>
</table>
	  

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>


### CreateMarkColumn <small class="text-muted">method</small>

<hr />
<p class="lead">Create a mark column of MarkColumn property</p>

#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0     
      
      
      

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

### GetColumnTotal <small class="text-muted">method</small>

<hr />
<p class="lead">Get sum of especified column</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
      
<div class="table-responsive">
  <h4>Parâmetros</h4>
  <table class="table table-striped table-bordered table-hover table-condensed">
    <thead>
      <tr>
        <th>Nome</th>
        <th>Tipo</th>
        <th>Uso</th>
        <th>Descrição</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>cColumn</td>
        <td>caractere</td>
        <td>true</td>
        <td>
          Name of col to sumName of col to sumName of col to sumName of
          col to sumName of col to sumName of col to sumName of col to
          sumName of col to sumName of col to sumName of col to sum.
        </td>
      </tr>
    </tbody>
  </table>
</div>
#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>
 


### GetRowsCount <small class="text-muted">method</small>

<hr />
<p class="lead">Get number of rows</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
      
      
      
#### Retorno
<table class="table table-striped table-bordered table-hover table-condensed">
<thead>
  <tr>
    <th>Tipo</th>
    <th>Descrição</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>numeric</td>
    <td>NumRows</td>
  </tr>
</tbody>
</table>


#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>


### AdjustAFields <small class="text-muted">method</small>

<hr />
<p class="lead">Adjust Columns property from FieldsGried</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
      

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

### CreateBrw <small class="text-muted">method</small>
<hr />
<p class="lead">Create a RbtBrowse pre configured</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
#### Exemplo
     

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

### Create <small class="text-muted">method</small>
<hr />
<p class="lead">Create browse before activate</p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0

<div class="table-responsive">
  <h4>Parâmetros</h4>
  <table class="table table-striped table-bordered table-hover table-condensed">
    <thead>
      <tr>
        <th>Nome</th>
        <th>Tipo</th>
        <th>Uso</th>
        <th>Descrição</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>oParent</td>
        <td>object</td>
        <td>false</td>
        <td>Parent containner</td>
      </tr>
    </tbody>
  </table>
</div>


#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>


### Destroy <small class="text-muted">method</small>
<hr />
<p class="lead"></p>
      
#### Autor
    Roberto Alves
#### Desde
    13/03/2020
#### Versão
    1.3.0
      

#### Veja também
 <a href="https://www.rbtsistemas.com.br/utils/utils.php" target="_blank">Rbt Sistemas</a>

