/* parser generated by jison 0.4.18 */
/*
  Returns a Parser object of the following structure:

  Parser: {
    yy: {}
  }

  Parser.prototype: {
    yy: {},
    trace: function(),
    symbols_: {associative list: name ==> number},
    terminals_: {associative list: number ==> name},
    productions_: [...],
    performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate, $$, _$),
    table: [...],
    defaultActions: {...},
    parseError: function(str, hash),
    parse: function(input),

    lexer: {
        EOF: 1,
        parseError: function(str, hash),
        setInput: function(input),
        input: function(),
        unput: function(str),
        more: function(),
        less: function(n),
        pastInput: function(),
        upcomingInput: function(),
        showPosition: function(),
        test_match: function(regex_match_array, rule_index),
        next: function(),
        lex: function(),
        begin: function(condition),
        popState: function(),
        _currentRules: function(),
        topState: function(),
        pushState: function(condition),

        options: {
            ranges: boolean           (optional: true ==> token location info will include a .range[] member)
            flex: boolean             (optional: true ==> flex-like lexing behaviour where the rules are tested exhaustively to find the longest match)
            backtrack_lexer: boolean  (optional: true ==> lexer regexes are tested in order and for each matching regex the action code is invoked; the lexer terminates the scan when a token is returned by the action code)
        },

        performAction: function(yy, yy_, $avoiding_name_collisions, YY_START),
        rules: [...],
        conditions: {associative list: name ==> set},
    }
  }


  token location info (@$, _$, etc.): {
    first_line: n,
    last_line: n,
    first_column: n,
    last_column: n,
    range: [start_number, end_number]       (where the numbers are indexes into the input string, regular zero-based)
  }


  the parseError function receives a 'hash' object with these members for lexer and parser errors: {
    text:        (matched text)
    token:       (the produced terminal token, if any)
    line:        (yylineno)
  }
  while parser (grammar) errors will also provide these members, i.e. parser errors deliver a superset of attributes: {
    loc:         (yylloc)
    expected:    (string describing the set of expected tokens)
    recoverable: (boolean: TRUE when the parser has a error recovery rule available for this particular error)
  }
*/
var Analizador = (function(){
var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,8],$V1=[1,10],$V2=[1,13],$V3=[1,14],$V4=[1,15],$V5=[1,16],$V6=[1,17],$V7=[1,18],$V8=[1,19],$V9=[1,20],$Va=[5,10,12,24,41,58,59,60,61,62,63],$Vb=[1,25],$Vc=[1,26],$Vd=[1,28],$Ve=[5,10,12,20,24,31,33,41,58,59,60,61,62,63],$Vf=[1,33],$Vg=[1,30],$Vh=[23,24],$Vi=[5,10,12,18,20,21,24,30,31,33,41,49,53,58,59,60,61,62,63],$Vj=[5,10,12,18,20,24,31,33,41,49,53,58,59,60,61,62,63],$Vk=[1,44],$Vl=[1,43],$Vm=[1,45],$Vn=[1,46],$Vo=[1,47],$Vp=[1,53],$Vq=[1,63],$Vr=[5,10,12,15,18,20,21,24,31,33,38,41,49,53,58,59,60,61,62,63],$Vs=[1,83],$Vt=[1,89],$Vu=[1,84],$Vv=[1,85],$Vw=[1,86],$Vx=[1,87],$Vy=[1,88],$Vz=[1,102],$VA=[1,99],$VB=[1,103],$VC=[1,100],$VD=[1,101],$VE=[1,112],$VF=[1,114],$VG=[1,118],$VH=[5,10,12,15,21,24,41,58,59,60,61,62,63],$VI=[18,20,24,31,33,49,53,58,59,60,61,62,63],$VJ=[1,164],$VK=[18,20,24,49,53,58,59,60,61,62,63],$VL=[12,18,20,24,31,33,49,53,58,59,60,61,62,63];
var parser = {trace: function trace () { },
yy: {},
symbols_: {"error":2,"ini":3,"ENTRADA":4,"EOF":5,"instrucciones":6,"Mainbody":7,"FuncionesMetodos":8,"Dec_Var":9,"Dec_Vec":10,"Dec_Structs":11,"TK_VOID":12,"TK_MAIN":13,"PARENTESIS_ABRE":14,"PARENTESIS_CIERRA":15,"LlaveAbre":16,"cuerpomain":17,"LlaveCierra":18,"imprimir":19,"TK_RETURN":20,"TK_PYC":21,"tipos":22,"TK_FUNCTION":23,"IDENTIFICADOR":24,"cuerpoFunction":25,"listaparametros":26,"cuerpoMetodo":27,"LlamadaMF":28,"SentenciasControl":29,"TK_COMA":30,"TK_PRINT":31,"impresion":32,"TK_PRINTLN":33,"CADENA":34,"ENTERO":35,"DECI":36,"CARACTER":37,"OP_SUMA":38,"IGUAL":39,"cadvar":40,"TK_STRUCT":41,"listatributos":42,"params":43,"TK_PUNTO":44,"NULL":45,"TRUE":46,"FALSE":47,"ControlIF":48,"ControlSwitch":49,"if":50,"ifelse":51,"elseif":52,"TK_IF":53,"condiciones":54,"instIf":55,"TK_ELSE":56,"IGUALIGUAL":57,"STRING":58,"INT":59,"DOUBLE":60,"CHAR":61,"FLOAT":62,"BOOLEAN":63,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",10:"Dec_Vec",12:"TK_VOID",13:"TK_MAIN",14:"PARENTESIS_ABRE",15:"PARENTESIS_CIERRA",16:"LlaveAbre",18:"LlaveCierra",20:"TK_RETURN",21:"TK_PYC",23:"TK_FUNCTION",24:"IDENTIFICADOR",30:"TK_COMA",31:"TK_PRINT",33:"TK_PRINTLN",34:"CADENA",35:"ENTERO",36:"DECI",37:"CARACTER",38:"OP_SUMA",39:"IGUAL",41:"TK_STRUCT",44:"TK_PUNTO",45:"NULL",46:"TRUE",47:"FALSE",49:"ControlSwitch",53:"TK_IF",56:"TK_ELSE",57:"IGUALIGUAL",58:"STRING",59:"INT",60:"DOUBLE",61:"CHAR",62:"FLOAT",63:"BOOLEAN"},
productions_: [0,[3,2],[3,2],[4,2],[4,1],[6,1],[6,1],[6,1],[6,1],[6,1],[7,7],[17,2],[17,2],[17,2],[17,2],[8,8],[8,9],[8,8],[8,9],[8,10],[8,9],[8,1],[25,1],[25,7],[25,6],[25,5],[25,6],[25,2],[25,2],[26,2],[26,4],[26,1],[26,3],[27,1],[27,1],[27,1],[27,2],[27,2],[27,2],[19,5],[19,4],[19,5],[19,4],[32,1],[32,1],[32,1],[32,1],[32,1],[32,3],[9,5],[9,4],[9,3],[9,4],[9,3],[9,2],[40,1],[40,3],[11,6],[11,8],[11,6],[11,5],[11,6],[42,2],[42,4],[43,1],[43,1],[43,1],[43,1],[43,1],[43,1],[43,1],[43,3],[43,3],[43,3],[43,3],[43,3],[43,3],[43,3],[28,5],[28,4],[28,3],[28,4],[29,1],[29,1],[48,1],[48,1],[48,1],[50,7],[50,6],[51,11],[51,10],[51,10],[51,9],[52,8],[52,8],[54,3],[55,1],[22,1],[22,1],[22,1],[22,1],[22,1],[22,1]],
performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
/* this == yyval */

var $0 = $$.length - 1;
switch (yystate) {
case 1:
 typeof console !== 'undefined' ? console.log($$[$0-1]) : print($$[$0-1]); return $$[$0-1]; 
break;
}
},
table: [{2:[1,3],3:1,4:2,6:4,7:5,8:6,9:7,10:$V0,11:9,12:$V1,22:11,24:$V2,28:12,41:$V3,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{1:[3]},{5:[1,21],6:22,7:5,8:6,9:7,10:$V0,11:9,12:$V1,22:11,24:$V2,28:12,41:$V3,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{5:[1,23]},o($Va,[2,4]),o($Va,[2,5]),o($Va,[2,6]),o($Va,[2,7]),o($Va,[2,8]),o($Va,[2,9]),{13:[1,24],23:$Vb,24:$Vc},{23:[1,27],24:$Vd,40:29},o($Ve,[2,21]),{14:$Vf,24:[1,31],39:$Vg,44:[1,32]},{24:[1,34]},o($Vh,[2,97]),o($Vh,[2,98]),o($Vh,[2,99]),o($Vh,[2,100]),o($Vh,[2,101]),o($Vh,[2,102]),{1:[2,1]},o($Va,[2,3]),{1:[2,2]},{14:[1,35]},{24:[1,36]},{14:[1,37]},{24:[1,38]},o($Vi,[2,55],{39:[1,39]}),o($Vj,[2,54],{21:[1,40],30:[1,41]}),{24:$Vk,32:42,34:$Vl,35:$Vm,36:$Vn,37:$Vo},{39:[1,48]},{24:[1,49]},{15:[1,51],22:52,24:$Vp,26:50,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{16:[1,54]},{15:[1,55]},{14:[1,56]},{15:[1,58],22:52,24:$Vp,26:57,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{14:[1,59]},{24:$Vk,32:60,34:$Vl,35:$Vm,36:$Vn,37:$Vo},o($Vj,[2,53]),{24:[1,61]},o($Vj,[2,51],{21:[1,62],38:$Vq}),o($Vr,[2,43]),o($Vr,[2,44]),o($Vr,[2,45]),o($Vr,[2,46]),o($Vr,[2,47]),{24:[1,64]},{39:[1,65]},{15:[1,66]},o($Ve,[2,80],{21:[1,67]}),{24:[1,68]},{15:[2,31],30:[1,69]},{22:71,42:70,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{16:[1,72]},{15:[1,73],22:52,24:$Vp,26:74,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{15:[1,75]},{16:[1,76]},{15:[1,77],22:52,24:$Vp,26:78,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},o($Vj,[2,52],{21:[1,79],38:$Vq}),o($Vi,[2,56]),o($Vj,[2,50]),{24:$Vk,32:80,34:$Vl,35:$Vm,36:$Vn,37:$Vo},{14:[1,81]},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:82,45:$Vw,46:$Vx,47:$Vy},o($Ve,[2,79],{21:[1,90]}),o($Ve,[2,81]),{15:[2,29],30:[1,91]},{22:52,24:$Vp,26:92,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{18:[1,93]},{24:[1,94]},{8:97,9:98,12:$Vz,17:95,19:96,20:$VA,22:11,24:$VB,28:12,31:$VC,33:$VD,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{16:[1,104]},{15:[1,105]},{16:[1,106]},{9:109,19:108,22:111,24:$VE,27:107,29:110,31:$VC,33:$VD,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{16:[1,119]},{15:[1,120]},o($Vj,[2,49]),o($Vr,[2,48]),{15:[1,122],24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:121,45:$Vw,46:$Vx,47:$Vy},o($Va,[2,60],{21:[1,123]}),o($VH,[2,64],{30:[1,124]}),o($VH,[2,65],{30:[1,125]}),o($VH,[2,66],{30:[1,126]}),o($VH,[2,67],{30:[1,127]}),o($VH,[2,68],{30:[1,128]}),o($VH,[2,69],{30:[1,129]}),o($VH,[2,70],{30:[1,130]}),o($Ve,[2,78]),{22:52,24:$Vp,26:131,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{15:[2,32]},{21:[1,132]},{18:[2,62],30:[1,133]},{18:[1,134]},{8:97,9:98,12:$Vz,17:135,19:96,20:$VA,22:11,24:$VB,28:12,31:$VC,33:$VD,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{8:97,9:98,12:$Vz,17:136,19:96,20:$VA,22:11,24:$VB,28:12,31:$VC,33:$VD,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{8:97,9:98,12:$Vz,17:137,19:96,20:$VA,22:11,24:$VB,28:12,31:$VC,33:$VD,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{21:[1,138]},{14:[1,139]},{14:[1,140]},{23:$Vb,24:$Vc},{14:$Vf,39:$Vg},{19:142,25:141,31:$VC,33:$VD},{16:[1,143]},{9:109,19:108,22:111,24:$VE,27:144,29:110,31:$VC,33:$VD,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{20:[1,145]},{9:109,19:108,20:[2,33],22:111,24:$VE,27:146,29:110,31:$VC,33:$VD,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{9:109,19:108,20:[2,34],22:111,24:$VE,27:147,29:110,31:$VC,33:$VD,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{9:109,19:108,20:[2,35],22:111,24:$VE,27:148,29:110,31:$VC,33:$VD,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{24:$Vd,40:29},{39:$Vg},o($VI,[2,82]),o($VI,[2,83]),o($VI,[2,84]),o($VI,[2,85]),o($VI,[2,86]),{14:[1,149]},{19:142,25:150,31:$VC,33:$VD},{16:[1,151]},{15:[1,152]},o($Va,[2,59]),o($Va,[2,61]),{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:153,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:154,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:155,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:156,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:157,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:158,45:$Vw,46:$Vx,47:$Vy},{24:$Vs,34:$Vt,35:$Vu,36:$Vv,43:159,45:$Vw,46:$Vx,47:$Vy},{15:[2,30]},o($Va,[2,57]),{22:71,42:160,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},o($Va,[2,10]),{18:[2,11]},{18:[2,12]},{18:[2,13]},{18:[2,14]},{24:$Vk,32:161,34:$Vl,35:$Vm,36:$Vn,37:$Vo},{24:$Vk,32:162,34:$Vl,35:$Vm,36:$Vn,37:$Vo},{9:165,18:[1,163],20:$VJ,22:111,24:$VE,29:166,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},o($VK,[2,22]),{19:142,25:167,31:$VC,33:$VD},{20:[1,168]},{21:[1,169]},{20:[2,36]},{20:[2,37]},{20:[2,38]},{15:[1,171],24:[1,172],54:170},{9:165,18:[1,173],20:$VJ,22:111,24:$VE,29:166,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{19:142,25:174,31:$VC,33:$VD},{21:[1,175]},o($VH,[2,71]),o($VH,[2,72]),o($VH,[2,73]),o($VH,[2,74]),o($VH,[2,75]),o($VH,[2,76]),o($VH,[2,77]),{18:[2,63]},{15:[1,176],38:$Vq},{15:[1,177],38:$Vq},o($Ve,[2,17]),{24:[1,178]},o($VK,[2,27]),o($VK,[2,28]),{9:165,18:[1,179],20:$VJ,22:111,24:$VE,29:166,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},{21:[1,180]},{18:[1,181]},{15:[1,182]},{16:[1,183]},{57:[1,184]},o($Ve,[2,15]),{9:165,18:[1,185],20:$VJ,22:111,24:$VE,29:166,48:113,49:$VF,50:115,51:116,52:117,53:$VG,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},o($Va,[2,58]),o($VL,[2,40],{21:[1,186]}),o($VL,[2,42],{21:[1,187]}),{14:[1,188]},o($Ve,[2,18]),{18:[1,189]},o($Ve,[2,20]),{16:[1,190]},{19:192,31:$VC,33:$VD,55:191},{24:[1,193]},o($Ve,[2,16]),o($VL,[2,39]),o($VL,[2,41]),{15:[1,195],22:52,24:$Vp,26:194,58:$V4,59:$V5,60:$V6,61:$V7,62:$V8,63:$V9},o($Ve,[2,19]),{18:[1,197],19:192,31:$VC,33:$VD,55:196},{18:[1,198]},{18:[2,96]},{15:[2,95]},{15:[1,199]},o($VK,[2,25],{21:[1,200]}),{18:[1,201]},o($VI,[2,88],{56:[1,202]}),{56:[1,203]},o($VK,[2,24],{21:[1,204]}),o($VK,[2,26]),o($VI,[2,87],{56:[1,205]}),{16:[1,206],48:207,50:115,51:116,52:117,53:$VG},{48:208,50:115,51:116,52:117,53:$VG},o($VK,[2,23]),{16:[1,209]},{18:[1,211],19:192,31:$VC,33:$VD,55:210},o($VI,[2,94]),o($VI,[2,93]),{18:[1,213],19:192,31:$VC,33:$VD,55:212},{18:[1,214]},o($VI,[2,92]),{18:[1,215]},o($VI,[2,91]),o($VI,[2,90]),o($VI,[2,89])],
defaultActions: {21:[2,1],23:[2,2],92:[2,32],131:[2,30],135:[2,11],136:[2,12],137:[2,13],138:[2,14],146:[2,36],147:[2,37],148:[2,38],160:[2,63],192:[2,96],193:[2,95]},
parseError: function parseError (str, hash) {
    if (hash.recoverable) {
        this.trace(str);
    } else {
        var error = new Error(str);
        error.hash = hash;
        throw error;
    }
},
parse: function parse (input) {
    var self = this,
        stack = [0],
        tstack = [], // token stack
        vstack = [null], // semantic value stack
        lstack = [], // location stack
        table = this.table,
        yytext = '',
        yylineno = 0,
        yyleng = 0,
        recovering = 0,
        TERROR = 2,
        EOF = 1;

    var args = lstack.slice.call(arguments, 1);

    //this.reductionCount = this.shiftCount = 0;

    var lexer = Object.create(this.lexer);
    var sharedState = { yy: {} };
    // copy state
    for (var k in this.yy) {
      if (Object.prototype.hasOwnProperty.call(this.yy, k)) {
        sharedState.yy[k] = this.yy[k];
      }
    }

    lexer.setInput(input, sharedState.yy);
    sharedState.yy.lexer = lexer;
    sharedState.yy.parser = this;
    if (typeof lexer.yylloc == 'undefined') {
        lexer.yylloc = {};
    }
    var yyloc = lexer.yylloc;
    lstack.push(yyloc);

    var ranges = lexer.options && lexer.options.ranges;

    if (typeof sharedState.yy.parseError === 'function') {
        this.parseError = sharedState.yy.parseError;
    } else {
        this.parseError = Object.getPrototypeOf(this).parseError;
    }

    function popStack (n) {
        stack.length = stack.length - 2 * n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }

_token_stack:
    var lex = function () {
        var token;
        token = lexer.lex() || EOF;
        // if token isn't its numeric value, convert
        if (typeof token !== 'number') {
            token = self.symbols_[token] || token;
        }
        return token;
    }

    var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
    while (true) {
        // retreive state number from top of stack
        state = stack[stack.length - 1];

        // use default actions if available
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol === null || typeof symbol == 'undefined') {
                symbol = lex();
            }
            // read action for current state and first input
            action = table[state] && table[state][symbol];
        }

_handle_error:
        // handle parse error
        if (typeof action === 'undefined' || !action.length || !action[0]) {
            var error_rule_depth;
            var errStr = '';

            // Return the rule stack depth where the nearest error rule can be found.
            // Return FALSE when no error recovery rule was found.
            function locateNearestErrorRecoveryRule(state) {
                var stack_probe = stack.length - 1;
                var depth = 0;

                // try to recover from error
                for(;;) {
                    // check for error recovery rule in this state
                    if ((TERROR.toString()) in table[state]) {
                        return depth;
                    }
                    if (state === 0 || stack_probe < 2) {
                        return false; // No suitable error recovery rule available.
                    }
                    stack_probe -= 2; // popStack(1): [symbol, action]
                    state = stack[stack_probe];
                    ++depth;
                }
            }

            if (!recovering) {
                // first see if there's any chance at hitting an error recovery rule:
                error_rule_depth = locateNearestErrorRecoveryRule(state);

                // Report error
                expected = [];
                for (p in table[state]) {
                    if (this.terminals_[p] && p > TERROR) {
                        expected.push("'"+this.terminals_[p]+"'");
                    }
                }
                if (lexer.showPosition) {
                    errStr = 'Parse error on line '+(yylineno+1)+":\n"+lexer.showPosition()+"\nExpecting "+expected.join(', ') + ", got '" + (this.terminals_[symbol] || symbol)+ "'";
                } else {
                    errStr = 'Parse error on line '+(yylineno+1)+": Unexpected " +
                                  (symbol == EOF ? "end of input" :
                                              ("'"+(this.terminals_[symbol] || symbol)+"'"));
                }
                this.parseError(errStr, {
                    text: lexer.match,
                    token: this.terminals_[symbol] || symbol,
                    line: lexer.yylineno,
                    loc: yyloc,
                    expected: expected,
                    recoverable: (error_rule_depth !== false)
                });
            } else if (preErrorSymbol !== EOF) {
                error_rule_depth = locateNearestErrorRecoveryRule(state);
            }

            // just recovered from another error
            if (recovering == 3) {
                if (symbol === EOF || preErrorSymbol === EOF) {
                    throw new Error(errStr || 'Parsing halted while starting to recover from another error.');
                }

                // discard current lookahead and grab another
                yyleng = lexer.yyleng;
                yytext = lexer.yytext;
                yylineno = lexer.yylineno;
                yyloc = lexer.yylloc;
                symbol = lex();
            }

            // try to recover from error
            if (error_rule_depth === false) {
                throw new Error(errStr || 'Parsing halted. No suitable error recovery rule available.');
            }
            popStack(error_rule_depth);

            preErrorSymbol = (symbol == TERROR ? null : symbol); // save the lookahead token
            symbol = TERROR;         // insert generic error symbol as new lookahead
            state = stack[stack.length-1];
            action = table[state] && table[state][TERROR];
            recovering = 3; // allow 3 real symbols to be shifted before reporting a new error
        }

        // this shouldn't happen, unless resolve defaults are off
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);
        }

        switch (action[0]) {
            case 1: // shift
                //this.shiftCount++;

                stack.push(symbol);
                vstack.push(lexer.yytext);
                lstack.push(lexer.yylloc);
                stack.push(action[1]); // push state
                symbol = null;
                if (!preErrorSymbol) { // normal execution/no error
                    yyleng = lexer.yyleng;
                    yytext = lexer.yytext;
                    yylineno = lexer.yylineno;
                    yyloc = lexer.yylloc;
                    if (recovering > 0) {
                        recovering--;
                    }
                } else {
                    // error just occurred, resume old lookahead f/ before error
                    symbol = preErrorSymbol;
                    preErrorSymbol = null;
                }
                break;

            case 2:
                // reduce
                //this.reductionCount++;

                len = this.productions_[action[1]][1];

                // perform semantic action
                yyval.$ = vstack[vstack.length-len]; // default to $$ = $1
                // default location, uses first token for firsts, last for lasts
                yyval._$ = {
                    first_line: lstack[lstack.length-(len||1)].first_line,
                    last_line: lstack[lstack.length-1].last_line,
                    first_column: lstack[lstack.length-(len||1)].first_column,
                    last_column: lstack[lstack.length-1].last_column
                };
                if (ranges) {
                  yyval._$.range = [lstack[lstack.length-(len||1)].range[0], lstack[lstack.length-1].range[1]];
                }
                r = this.performAction.apply(yyval, [yytext, yyleng, yylineno, sharedState.yy, action[1], vstack, lstack].concat(args));

                if (typeof r !== 'undefined') {
                    return r;
                }

                // pop off stack
                if (len) {
                    stack = stack.slice(0,-1*len*2);
                    vstack = vstack.slice(0, -1*len);
                    lstack = lstack.slice(0, -1*len);
                }

                stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)
                vstack.push(yyval.$);
                lstack.push(yyval._$);
                // goto new state = table[STATE][NONTERMINAL]
                newState = table[stack[stack.length-2]][stack[stack.length-1]];
                stack.push(newState);
                break;

            case 3:
                // accept
                return true;
        }

    }

    return true;
}};

    var cadena = '';
    var errores = [];
/* generated by jison-lex 0.3.4 */
var lexer = (function(){
var lexer = ({

EOF:1,

parseError:function parseError(str, hash) {
        if (this.yy.parser) {
            this.yy.parser.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },

// resets the lexer, sets new input
setInput:function (input, yy) {
        this.yy = yy || this.yy || {};
        this._input = input;
        this._more = this._backtrack = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {
            first_line: 1,
            first_column: 0,
            last_line: 1,
            last_column: 0
        };
        if (this.options.ranges) {
            this.yylloc.range = [0,0];
        }
        this.offset = 0;
        return this;
    },

// consumes and returns one char from the input
input:function () {
        var ch = this._input[0];
        this.yytext += ch;
        this.yyleng++;
        this.offset++;
        this.match += ch;
        this.matched += ch;
        var lines = ch.match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno++;
            this.yylloc.last_line++;
        } else {
            this.yylloc.last_column++;
        }
        if (this.options.ranges) {
            this.yylloc.range[1]++;
        }

        this._input = this._input.slice(1);
        return ch;
    },

// unshifts one char (or a string) into the input
unput:function (ch) {
        var len = ch.length;
        var lines = ch.split(/(?:\r\n?|\n)/g);

        this._input = ch + this._input;
        this.yytext = this.yytext.substr(0, this.yytext.length - len);
        //this.yyleng -= len;
        this.offset -= len;
        var oldLines = this.match.split(/(?:\r\n?|\n)/g);
        this.match = this.match.substr(0, this.match.length - 1);
        this.matched = this.matched.substr(0, this.matched.length - 1);

        if (lines.length - 1) {
            this.yylineno -= lines.length - 1;
        }
        var r = this.yylloc.range;

        this.yylloc = {
            first_line: this.yylloc.first_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.first_column,
            last_column: lines ?
                (lines.length === oldLines.length ? this.yylloc.first_column : 0)
                 + oldLines[oldLines.length - lines.length].length - lines[0].length :
              this.yylloc.first_column - len
        };

        if (this.options.ranges) {
            this.yylloc.range = [r[0], r[0] + this.yyleng - len];
        }
        this.yyleng = this.yytext.length;
        return this;
    },

// When called from action, caches matched text and appends it on next action
more:function () {
        this._more = true;
        return this;
    },

// When called from action, signals the lexer that this rule fails to match the input, so the next matching rule (regex) should be tested instead.
reject:function () {
        if (this.options.backtrack_lexer) {
            this._backtrack = true;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. You can only invoke reject() in the lexer when the lexer is of the backtracking persuasion (options.backtrack_lexer = true).\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });

        }
        return this;
    },

// retain first n characters of the match
less:function (n) {
        this.unput(this.match.slice(n));
    },

// displays already matched input, i.e. for error messages
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },

// displays upcoming input, i.e. for error messages
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20) + (next.length > 20 ? '...' : '')).replace(/\n/g, "");
    },

// displays the character position where the lexing error occurred, i.e. for error messages
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c + "^";
    },

// test the lexed token: return FALSE when not a match, otherwise return token
test_match:function(match, indexed_rule) {
        var token,
            lines,
            backup;

        if (this.options.backtrack_lexer) {
            // save context
            backup = {
                yylineno: this.yylineno,
                yylloc: {
                    first_line: this.yylloc.first_line,
                    last_line: this.last_line,
                    first_column: this.yylloc.first_column,
                    last_column: this.yylloc.last_column
                },
                yytext: this.yytext,
                match: this.match,
                matches: this.matches,
                matched: this.matched,
                yyleng: this.yyleng,
                offset: this.offset,
                _more: this._more,
                _input: this._input,
                yy: this.yy,
                conditionStack: this.conditionStack.slice(0),
                done: this.done
            };
            if (this.options.ranges) {
                backup.yylloc.range = this.yylloc.range.slice(0);
            }
        }

        lines = match[0].match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno += lines.length;
        }
        this.yylloc = {
            first_line: this.yylloc.last_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.last_column,
            last_column: lines ?
                         lines[lines.length - 1].length - lines[lines.length - 1].match(/\r?\n?/)[0].length :
                         this.yylloc.last_column + match[0].length
        };
        this.yytext += match[0];
        this.match += match[0];
        this.matches = match;
        this.yyleng = this.yytext.length;
        if (this.options.ranges) {
            this.yylloc.range = [this.offset, this.offset += this.yyleng];
        }
        this._more = false;
        this._backtrack = false;
        this._input = this._input.slice(match[0].length);
        this.matched += match[0];
        token = this.performAction.call(this, this.yy, this, indexed_rule, this.conditionStack[this.conditionStack.length - 1]);
        if (this.done && this._input) {
            this.done = false;
        }
        if (token) {
            return token;
        } else if (this._backtrack) {
            // recover context
            for (var k in backup) {
                this[k] = backup[k];
            }
            return false; // rule action called reject() implying the next rule should be tested instead.
        }
        return false;
    },

// return next match in input
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) {
            this.done = true;
        }

        var token,
            match,
            tempMatch,
            index;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i = 0; i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (this.options.backtrack_lexer) {
                    token = this.test_match(tempMatch, rules[i]);
                    if (token !== false) {
                        return token;
                    } else if (this._backtrack) {
                        match = false;
                        continue; // rule action called reject() implying a rule MISmatch.
                    } else {
                        // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
                        return false;
                    }
                } else if (!this.options.flex) {
                    break;
                }
            }
        }
        if (match) {
            token = this.test_match(match, rules[index]);
            if (token !== false) {
                return token;
            }
            // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
            return false;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. Unrecognized text.\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });
        }
    },

// return next match that has a token
lex:function lex () {
        var r = this.next();
        if (r) {
            return r;
        } else {
            return this.lex();
        }
    },

// activates a new lexer condition state (pushes the new lexer condition state onto the condition stack)
begin:function begin (condition) {
        this.conditionStack.push(condition);
    },

// pop the previously active lexer condition state off the condition stack
popState:function popState () {
        var n = this.conditionStack.length - 1;
        if (n > 0) {
            return this.conditionStack.pop();
        } else {
            return this.conditionStack[0];
        }
    },

// produce the lexer rule set which is active for the currently active lexer condition state
_currentRules:function _currentRules () {
        if (this.conditionStack.length && this.conditionStack[this.conditionStack.length - 1]) {
            return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules;
        } else {
            return this.conditions["INITIAL"].rules;
        }
    },

// return the currently active lexer condition state; when an index argument is provided it produces the N-th previous condition state, if available
topState:function topState (n) {
        n = this.conditionStack.length - 1 - Math.abs(n || 0);
        if (n >= 0) {
            return this.conditionStack[n];
        } else {
            return "INITIAL";
        }
    },

// alias for begin(condition)
pushState:function pushState (condition) {
        this.begin(condition);
    },

// return the number of states currently on the stack
stateStackSize:function stateStackSize() {
        return this.conditionStack.length;
    },
options: {},
performAction: function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {
var YYSTATE=YY_START;
switch($avoiding_name_collisions) {
case 0:// Espacios en blanco
break;
case 1:// Comentarios de una linea
break;
case 2:// Comentario Multilinea
break;
case 3:return 60
break;
case 4:return 59
break;
case 5:return 63
break;
case 6:return 61
break;
case 7:return 62
break;
case 8:return 58
break;
case 9:return 45
break;
case 10:return 53
break;
case 11:return 56
break;
case 12:return 'TK_SWITCH'
break;
case 13:return 'TK_CASE'
break;
case 14:return 'TK_BREAK'
break;
case 15:return 'TK_DEFAULT'
break;
case 16:return 'TK_WHILE'
break;
case 17:return 'TK_FOR'
break;
case 18:return 'TK_DO'
break;
case 19:return 'TK_CONTINUE'
break;
case 20:return 20
break;
case 21:return 12
break;
case 22:return 13
break;
case 23:return 'TK_POW'
break;
case 24:return 'TK_SQRT'
break;
case 25:return 'TK_SENO'
break;
case 26:return 'TK_COSENO'
break;
case 27:return 'TK_TANGENTE'
break;
case 28:return 'TK_LOGARITMOB10'
break;
case 29:return 'OR'
break;
case 30:return 'AND'
break;
case 31:return 'NOT'
break;
case 32:return 46
break;
case 33:return 47
break;
case 34:return 57
break;
case 35:return 'DIFERENTEA'
break;
case 36:return 'MAYOR'
break;
case 37:return 'MENOR'
break;
case 38:return 'MENORIGUAL'
break;
case 39:return 'MAYORIGUAL'
break;
case 40:return 39
break;
case 41:return 'CONCATENADOCADENA'
break;
case 42:return "OPERACIONESALIMPRIMIR"
break;
case 43:return "OP_VECOTRES"
break;
case 44:return 30
break;
case 45:return 21
break;
case 46:return 44
break;
case 47:return 'TK_DOSPUNTS'
break;
case 48:return 'OP_MULTIPLICACION'
break;
case 49:return 'OP_DIVISION'
break;
case 50:return 'OP_MENOS'
break;
case 51:return 38
break;
case 52:return 'OP_EXPONENTE'
break;
case 53:return 'OP_MODULO'
break;
case 54:return 'OP_TERNARIO'
break;
case 55:return 14
break;
case 56:return 15
break;
case 57:return 16
break;
case 58:return 18
break;
case 59:return 'COR_ABRE'
break;
case 60:return 'COR_CIERRA'
break;
case 61:return 'TK_CARACTEROFPOSITION'
break;
case 62:return 'TK_SUBSTRING'
break;
case 63:return 'TK_TOLOWER'
break;
case 64:return 'TK_TOUPPER'
break;
case 65:return 'TK_LENGTH'
break;
case 66:return 31
break;
case 67:return 33
break;
case 68:return 'TK_PARSE'
break;
case 69:return 'TK_TOINT'
break;
case 70:return 'TK_TODOUBLE'
break;
case 71:return 'TK_STRINGPARSE'
break;
case 72:return 'TK_TYPEOF'
break;
case 73:return 41
break;
case 74:return 'TK_BEGIN'
break;
case 75:return 'TK_END'
break;
case 76:return 'TK_PUSH'
break;
case 77:return 'TK_POP'
break;
case 78:return 23
break;
case 79:return 24
break;
case 80:return 37
break;
case 81:return 36
break;
case 82:return 35
break;
case 83: cadena = ''; this.begin("string"); 
break;
case 84: cadena += yy_.yytext; 
break;
case 85: cadena += "\""; 
break;
case 86: cadena += "\n"; 
break;
case 87: cadena += " ";  
break;
case 88: cadena += "\t"; 
break;
case 89: cadena += "\\"; 
break;
case 90: cadena += "\'"; 
break;
case 91: cadena += "\r"; 
break;
case 92: yy_.yytext = cadena; this.popState(); return 34; 
break;
case 93:return 5
break;
case 94: errores.push({ tipo: "Léxico", error: yy_.yytext, linea: yy_.yylloc.first_line, columna: yy_.yylloc.first_column+1 }); return 'INVALID'; 
break;
}
},
rules: [/^(?:\s+)/,/^(?:\/\/.*)/,/^(?:[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/])/,/^(?:double\b)/,/^(?:int\b)/,/^(?:boolean\b)/,/^(?:char\b)/,/^(?:float\b)/,/^(?:String\b)/,/^(?:null\b)/,/^(?:if\b)/,/^(?:else\b)/,/^(?:switch\b)/,/^(?:case\b)/,/^(?:break\b)/,/^(?:default\b)/,/^(?:while\b)/,/^(?:for\b)/,/^(?:do\b)/,/^(?:continue\b)/,/^(?:return\b)/,/^(?:void\b)/,/^(?:main\b)/,/^(?:pow\b)/,/^(?:sqrt\b)/,/^(?:sin\b)/,/^(?:cos\b)/,/^(?:tan\b)/,/^(?:log10\b)/,/^(?:\|\|)/,/^(?:&&)/,/^(?:!)/,/^(?:true\b)/,/^(?:false\b)/,/^(?:==)/,/^(?:!=)/,/^(?:>)/,/^(?:<)/,/^(?:<=)/,/^(?:>=)/,/^(?:=)/,/^(?:&)/,/^(?:\$)/,/^(?:#)/,/^(?:,)/,/^(?:;)/,/^(?:\.)/,/^(?::)/,/^(?:\*)/,/^(?:\/)/,/^(?:-)/,/^(?:\+)/,/^(?:\^)/,/^(?:%)/,/^(?:\?)/,/^(?:\()/,/^(?:\))/,/^(?:\{)/,/^(?:\})/,/^(?:\[)/,/^(?:\])/,/^(?:caracterOfPosition\b)/,/^(?:subString\b)/,/^(?:toLowercase\b)/,/^(?:toUppercase\b)/,/^(?:length\b)/,/^(?:print\b)/,/^(?:println\b)/,/^(?:parse\b)/,/^(?:toInt\b)/,/^(?:toDouble\b)/,/^(?:string\b)/,/^(?:typeof\b)/,/^(?:struct\b)/,/^(?:begin\b)/,/^(?:end\b)/,/^(?:push\b)/,/^(?:pop\b)/,/^(?:function\b)/,/^(?:([a-zA-Z])([a-zA-Z0-9_])*)/,/^(?:[']\\\\[']|[']\\"[']|[']\\'[']|[']\\n[']|[']\\t[']|[']\\r[']|['].?['])/,/^(?:[0-9]+(\.[0-9]+)+\b)/,/^(?:[0-9]+)/,/^(?:["])/,/^(?:[^"\\]+)/,/^(?:\\")/,/^(?:\\n)/,/^(?:\s)/,/^(?:\\t)/,/^(?:\\\\)/,/^(?:\\\\')/,/^(?:\\r)/,/^(?:["])/,/^(?:$)/,/^(?:.)/],
conditions: {"string":{"rules":[84,85,86,87,88,89,90,91,92],"inclusive":false},"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,93,94],"inclusive":true}}
});
return lexer;
})();
parser.lexer = lexer;
function Parser () {
  this.yy = {};
}
Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();


if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = Analizador;
exports.Parser = Analizador.Parser;
exports.parse = function () { return Analizador.parse.apply(Analizador, arguments); };
exports.main = function commonjsMain (args) {
    if (!args[1]) {
        console.log('Usage: '+args[0]+' FILE');
        process.exit(1);
    }
    var source = require('fs').readFileSync(require('path').normalize(args[1]), "utf8");
    return exports.parser.parse(source);
};
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(process.argv.slice(1));
}
}