<div class="inner">
  <header>
    <h2>Documentação</h2>
  </header>
  <div id="contentFile">
    <div>
      <a id="RbtBrowse"></a>
      <h3>RbtBrowse <small class="text-muted">class</small></h3>


      <p class="lead">
        Class to create FwTemporaryTable/FwBrowse from FwBrowse with many
        features.
      </p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

  

      <h4>Exemplo</h4>
      <code>
          Local aItems := {} <br />
          Local aFields := {}<br />// Add a column especified<br />aAdd(aFields,{SELECOL',;
          // Name of col markup.<br />
          Sel,; //Title<br />
          1,;//Size<br />
          0,;//Decimal<br />
          ,;//Picture<br />
          L,;//Type<br />
          .F.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br />
          // then dont diplay in FwBrowse)<br /><br />//Add Col from SX3<br />aAdd(aFields,{B1_COD})
          <br />aAdd(aFields,{B1_DESC})<br /><br /><br />//Add a column especified
          Desc<br />aAdd(aFields,{'DESCRICAO',; // Name of col markup.<br />
          Desc,; //Title<br />
          9,;//Size<br />
          0,;//Decimal<br />
          @!,;//Picture<br />
          C,;//Type<br />
          .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br />//
          // then dont diplay in FwBrowse)<br /><br />//Add a column especified
          VaLOR<br />// aAdd(aFields,{VALOR',; // Name of col vlor.<br />
          Valor,; //Title<br />
          12,;//Size<br />
          2,;//Decimal<br />
          @!,;//Picture<br />
          N,;//Type<br />
          .T.}) //Visible (If .F. Create colunm in only FwTemporaryTable<br />//
          // then dont diplay in FwBrowse)<br /><br />//Add items from array at
          finish, in order of columns and add a logical in finish (Deleted)<br />
          aAdd(aItems,{.T.,CODIGO001,DESC COD 01,POR ITEM,15.20,.F.})<br />
          aAdd(aItems,{.T.,CODIGO002,DESC COD 02,POR ITEM2,10.50,.F.})<br /><br />
          oBrowse := RbtBrowse():New()<br />
          oBrowse:UseTempTable := .T.<br />
          oBrowse:CreateIndexs := .T.<br />
          oBrowse:MarkColumn := SELECOL<br />
          oBrowse:FieldsGrid := aFields<br />
          oBrowse:Items := aItems<br /><br />// //Add items from query dont need
          deleted default .F.<br />
          oBrowse:Query := SELECT TOP 100 'F' AS SELECOL,B1_COD,B1_DESC,'EXEMPLO'
          AS DESCRICAO, 0.00 AS VALOR +;<br />
          FROM +RETSQLNAME(SB1)+ WHERE D_E_L_E_T_&lt;&gt;'*'<br />
          oBrowse:Title := Titulo Browse<br />
          oBrowse:Create(oDlg)<br />// //Num rows<br />oBtn1:bAction := {||
            MsgAlert(cValToChar(oBrowse:GetRowsCount()),Linhas!) } <br />
            //Sum of col<br />oBtn2:bAction := {||
              MsgAlert(cValToChar(oBrowse:GetColumnTotal(VALOR)),Total)} <br />
              oBrowse:Activate()<br />
              ACTIVATE MSDIALOG oDlg CENTERED<br />
              Return<br/>
      </code>

      <h4>Veja também</h4>
      https://github.com/Rbt-Sistemas/Advpl

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="New"></a>
      <h3>New <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead"></p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>
      <h4>Retorno</h4>
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

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="SetFreeze"></a>
      <h3>SetFreeze <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">
        Index of col to freeze, just 1 by limitation of framework
      </p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
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

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="CreateTemp"></a>
      <h3>CreateTemp <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Create a FwTemporaryTable by FieldsGrid property</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>
      <h4>Outras Informações</h4>
      <table class="table table-striped table-bordered table-hover table-condensed">
        <tbody>
          <tr>
            <td>obs</td>
            <td>Need FieldsGrid property previous setted</td>
          </tr>
        </tbody>
      </table>

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="CreateMarkColumn"></a>
      <h3>CreateMarkColumn <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Create a mark column of MarkColumn property</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="GetColumnTotal"></a>
      <h3>GetColumnTotal <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Get sum of especified column</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
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

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="GetRowsCount"></a>
      <h3>GetRowsCount <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Get number of rows</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>
      <h4>Retorno</h4>
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

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="AdjustAFields"></a>
      <h3>AdjustAFields <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Adjust Columns property from FieldsGried</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="CreateBrw"></a>
      <h3>CreateBrw <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Create a RbtBrowse pre configured</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="Create"></a>
      <h3>Create <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead">Create browse before activate</p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
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

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
    <div>
      <a id="Destroy"></a>
      <h3>Destroy <small class="text-muted">method</small></h3>
      <hr />

      <p class="lead"></p>

      <dl>
        <dt>Autor</dt>
        <dd>Roberto Alves</dd>
        <dt>Desde</dt>
        <dd>13/03/2020</dd>
        <dt>Versão</dt>
        <dd>1.3.0</dd>
      </dl>

      <h3>Definição:</h3>

      <h4>Sintaxe</h4>

      <p>
        <code>%sintaxe%</code>
      </p>
      <div class="table-responsive"></div>

      <h4>Veja também</h4>

      <!--<a href="$ref.url" target="_blank">$ref.description</a>$ref.description-->
      <br />

      <br />
    </div>
  </div>
</div>
