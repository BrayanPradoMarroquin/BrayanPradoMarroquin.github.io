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
var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,7],$V1=[1,8],$V2=[1,9],$V3=[1,10],$V4=[1,11],$V5=[1,13],$V6=[1,14],$V7=[1,15],$V8=[1,16],$V9=[1,17],$Va=[1,18],$Vb=[5,9,10,11,12,13,34,35,36,37,38,39],$Vc=[2,37],$Vd=[23,24],$Ve=[1,33],$Vf=[1,32],$Vg=[1,44],$Vh=[1,45],$Vi=[1,46],$Vj=[1,60],$Vk=[1,59];
var parser = {trace: function trace () { },
yy: {},
symbols_: {"error":2,"ini":3,"ENTRADA":4,"EOF":5,"instrucciones":6,"Mainbody":7,"Funciones":8,"Metodos":9,"Variables":10,"Vectores":11,"Structs":12,"TK_VOID":13,"TK_MAIN":14,"PARENTESIS_ABRE":15,"PARENTESIS_CIERRA":16,"LlaveAbre":17,"cuerpomain":18,"LlaveCierra":19,"TK_RETURN":20,"TK_PYC":21,"tipos":22,"TK_FUNCTION":23,"IDENTIFICADOR":24,"cuerpoPrograma":25,"listaparametros":26,"imprimir":27,"TK_COMA":28,"TK_PRINT":29,"impresion":30,"TK_PRINTLN":31,"CADENA":32,"OP_SUMA":33,"STRING":34,"INT":35,"DOUBLE":36,"CHAR":37,"FLOAT":38,"BOOLEAN":39,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",9:"Metodos",10:"Variables",11:"Vectores",12:"Structs",13:"TK_VOID",14:"TK_MAIN",15:"PARENTESIS_ABRE",16:"PARENTESIS_CIERRA",17:"LlaveAbre",19:"LlaveCierra",20:"TK_RETURN",21:"TK_PYC",23:"TK_FUNCTION",24:"IDENTIFICADOR",28:"TK_COMA",29:"TK_PRINT",31:"TK_PRINTLN",32:"CADENA",33:"OP_SUMA",34:"STRING",35:"INT",36:"DOUBLE",37:"CHAR",38:"FLOAT",39:"BOOLEAN"},
productions_: [0,[3,2],[3,2],[4,2],[4,1],[6,1],[6,1],[6,1],[6,1],[6,1],[6,1],[7,7],[18,2],[8,8],[8,9],[25,1],[25,6],[25,5],[25,2],[25,3],[26,2],[26,4],[26,1],[26,3],[27,5],[27,4],[27,5],[27,4],[30,1],[30,1],[30,3],[22,1],[22,1],[22,1],[22,1],[22,1],[22,1],[22,1]],
performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
/* this == yyval */

var $0 = $$.length - 1;
switch (yystate) {
case 1:
 retorno = { parse: $$[$0-1], errores: errores }; errores = []; return retorno; 
break;
case 2:
 retorno = { parse: null, errores: errores }; errores = []; return retorno; 
break;
}
},
table: [{2:[1,3],3:1,4:2,6:4,7:5,8:6,9:$V0,10:$V1,11:$V2,12:$V3,13:$V4,22:12,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},{1:[3]},{5:[1,19],6:20,7:5,8:6,9:$V0,10:$V1,11:$V2,12:$V3,13:$V4,22:12,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},{5:[1,21]},o($Vb,[2,4]),o($Vb,[2,5]),o($Vb,[2,6]),o($Vb,[2,7]),o($Vb,[2,8]),o($Vb,[2,9]),o($Vb,[2,10]),{14:[1,22],23:$Vc},{23:[1,23]},o($Vd,[2,31]),o($Vd,[2,32]),o($Vd,[2,33]),o($Vd,[2,34]),o($Vd,[2,35]),o($Vd,[2,36]),{1:[2,1]},o($Vb,[2,3]),{1:[2,2]},{15:[1,24]},{24:[1,25]},{16:[1,26]},{15:[1,27]},{17:[1,28]},{13:$Ve,16:[1,29],22:31,24:$Vf,26:30,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},{18:34,20:[1,35]},{17:[1,36]},{16:[1,37]},{24:[1,38]},{16:[2,22],28:[1,39]},{24:$Vc},{19:[1,40]},{21:[1,41]},{20:$Vg,25:42,27:43,29:$Vh,31:$Vi},{17:[1,47]},{16:[2,20],28:[1,48]},{13:$Ve,22:31,24:$Vf,26:49,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},o($Vb,[2,11]),{19:[2,12]},{19:[1,50]},{19:[2,15]},{24:[1,51]},{15:[1,52]},{15:[1,53]},{20:$Vg,25:54,27:43,29:$Vh,31:$Vi},{13:$Ve,22:31,24:$Vf,26:55,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},{16:[2,23]},o($Vb,[2,13]),{15:[1,56],19:[2,18],21:[1,57]},{24:$Vj,30:58,32:$Vk},{24:$Vj,30:61,32:$Vk},{19:[1,62]},{16:[2,21]},{13:$Ve,22:31,24:$Vf,26:63,34:$V5,35:$V6,36:$V7,37:$V8,38:$V9,39:$Va},{19:[2,19]},{16:[1,64]},{16:[2,28]},{16:[2,29],33:[1,65]},{16:[1,66]},o($Vb,[2,14]),{16:[1,67]},{19:[2,25],21:[1,68]},{24:$Vj,30:69,32:$Vk},{19:[2,27],21:[1,70]},{19:[2,17],21:[1,71]},{19:[2,24]},{16:[2,30]},{19:[2,26]},{19:[2,16]}],
defaultActions: {19:[2,1],21:[2,2],33:[2,37],41:[2,12],43:[2,15],49:[2,23],55:[2,21],57:[2,19],59:[2,28],68:[2,24],69:[2,30],70:[2,26],71:[2,16]},
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
case 3:return 36
break;
case 4:return 35
break;
case 5:return 39
break;
case 6:return 37
break;
case 7:return 38
break;
case 8:return 34
break;
case 9:return 'TK_IF'
break;
case 10:return 'TK_ELSE'
break;
case 11:return 'TK_SWITCH'
break;
case 12:return 'TK_CASE'
break;
case 13:return 'TK_BREAK'
break;
case 14:return 'TK_DEFAULT'
break;
case 15:return 'TK_WHILE'
break;
case 16:return 'TK_FOR'
break;
case 17:return 'TK_DO'
break;
case 18:return 'TK_CONTINUE'
break;
case 19:return 20
break;
case 20:return 13
break;
case 21:return 14
break;
case 22:return 'TK_POW'
break;
case 23:return 'TK_SQRT'
break;
case 24:return 'TK_SENO'
break;
case 25:return 'TK_COSENO'
break;
case 26:return 'TK_TANGENTE'
break;
case 27:return 'TK_LOGARITMOB10'
break;
case 28:return 'OR'
break;
case 29:return 'AND'
break;
case 30:return 'NOT'
break;
case 31:return 'TRUE'
break;
case 32:return 'FALSE'
break;
case 33:return 'IGUALIGUAL'
break;
case 34:return 'DIFERENTEA'
break;
case 35:return 'MAYOR'
break;
case 36:return 'MENOR'
break;
case 37:return 'MENORIGUAL'
break;
case 38:return 'MAYORIGUAL'
break;
case 39:return 'IGUAL'
break;
case 40:return 'CONCATENADOCADENA'
break;
case 41:return "OPERACIONESALIMPRIMIR"
break;
case 42:return "OP_VECOTRES"
break;
case 43:return 28
break;
case 44:return 21
break;
case 45:return 'TK_PUNTO'
break;
case 46:return 'TK_DOSPUNTS'
break;
case 47:return 'OP_MULTIPLICACION'
break;
case 48:return 'OP_DIVISION'
break;
case 49:return 'OP_MENOS'
break;
case 50:return 33
break;
case 51:return 'OP_EXPONENTE'
break;
case 52:return 'OP_MODULO'
break;
case 53:return 'OP_TERNARIO'
break;
case 54:return 15
break;
case 55:return 16
break;
case 56:return 17
break;
case 57:return 19
break;
case 58:return 'COR_ABRE'
break;
case 59:return 'COR_CIERRA'
break;
case 60:return 'TK_CARACTEROFPOSITION'
break;
case 61:return 'TK_SUBSTRING'
break;
case 62:return 'TK_TOLOWER'
break;
case 63:return 'TK_TOUPPER'
break;
case 64:return 'TK_LENGTH'
break;
case 65:return 29
break;
case 66:return 31
break;
case 67:return 'TK_PARSE'
break;
case 68:return 'TK_TOINT'
break;
case 69:return 'TK_TODOUBLE'
break;
case 70:return 'TK_STRINGPARSE'
break;
case 71:return 'TK_TYPEOF'
break;
case 72:return 'TK_STRUCT'
break;
case 73:return 'TK_BEGIN'
break;
case 74:return 'TK_END'
break;
case 75:return 'TK_PUSH'
break;
case 76:return 'TK_POP'
break;
case 77:return 23
break;
case 78:return 24
break;
case 79:return 'CARACTER'
break;
case 80:return 'DECI'
break;
case 81:return 'ENTERO'
break;
case 82: cadena = ''; this.begin("string"); 
break;
case 83: cadena += yy_.yytext; 
break;
case 84: cadena += "\""; 
break;
case 85: cadena += "\n"; 
break;
case 86: cadena += " ";  
break;
case 87: cadena += "\t"; 
break;
case 88: cadena += "\\"; 
break;
case 89: cadena += "\'"; 
break;
case 90: cadena += "\r"; 
break;
case 91: yy_.yytext = cadena; this.popState(); return 32; 
break;
case 92:return 5
break;
case 93: errores.push({ tipo: "Léxico", error: yy_.yytext, linea: yy_.yylloc.first_line, columna: yy_.yylloc.first_column+1 }); return 'INVALID'; 
break;
}
},
rules: [/^(?:\s+)/,/^(?:\/\/.*)/,/^(?:[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/])/,/^(?:double\b)/,/^(?:int\b)/,/^(?:boolean\b)/,/^(?:char\b)/,/^(?:float\b)/,/^(?:String\b)/,/^(?:if\b)/,/^(?:else\b)/,/^(?:switch\b)/,/^(?:case\b)/,/^(?:break\b)/,/^(?:default\b)/,/^(?:while\b)/,/^(?:for\b)/,/^(?:do\b)/,/^(?:continue\b)/,/^(?:return\b)/,/^(?:void\b)/,/^(?:main\b)/,/^(?:pow\b)/,/^(?:sqrt\b)/,/^(?:sin\b)/,/^(?:cos\b)/,/^(?:tan\b)/,/^(?:log10\b)/,/^(?:\|\|)/,/^(?:&&)/,/^(?:!)/,/^(?:true\b)/,/^(?:false\b)/,/^(?:==)/,/^(?:!=)/,/^(?:>)/,/^(?:<)/,/^(?:<=)/,/^(?:>=)/,/^(?:=)/,/^(?:&)/,/^(?:\$)/,/^(?:#)/,/^(?:,)/,/^(?:;)/,/^(?:\.)/,/^(?::)/,/^(?:\*)/,/^(?:\/)/,/^(?:-)/,/^(?:\+)/,/^(?:\^)/,/^(?:%)/,/^(?:\?)/,/^(?:\()/,/^(?:\))/,/^(?:\{)/,/^(?:\})/,/^(?:\[)/,/^(?:\])/,/^(?:caracterOfPosition\b)/,/^(?:subString\b)/,/^(?:toLowercase\b)/,/^(?:toUppercase\b)/,/^(?:length\b)/,/^(?:print\b)/,/^(?:println\b)/,/^(?:parse\b)/,/^(?:toInt\b)/,/^(?:toDouble\b)/,/^(?:string\b)/,/^(?:typeof\b)/,/^(?:struct\b)/,/^(?:begin\b)/,/^(?:end\b)/,/^(?:push\b)/,/^(?:pop\b)/,/^(?:function\b)/,/^(?:([a-zA-Z])([a-zA-Z0-9_])*)/,/^(?:[']\\\\[']|[']\\"[']|[']\\'[']|[']\\n[']|[']\\t[']|[']\\r[']|['].?['])/,/^(?:[0-9]+(\.[0-9]+)+\b)/,/^(?:[0-9]+)/,/^(?:["])/,/^(?:[^"\\]+)/,/^(?:\\")/,/^(?:\\n)/,/^(?:\s)/,/^(?:\\t)/,/^(?:\\\\)/,/^(?:\\\\')/,/^(?:\\r)/,/^(?:["])/,/^(?:$)/,/^(?:.)/],
conditions: {"string":{"rules":[83,84,85,86,87,88,89,90,91],"inclusive":false},"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,92,93],"inclusive":true}}
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