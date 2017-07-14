"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const elixirAutocomplete_1 = require("./elixirAutocomplete");
const elixirServer_1 = require("./elixirServer");
const elixirDefinitionProvider_1 = require("./elixirDefinitionProvider");
const elixirHoverProvider_1 = require("./elixirHoverProvider");
const elixirConfiguration_1 = require("./elixirConfiguration");
//Elixir-Sense
const elixirSenseServerProcess_1 = require("./elixirSenseServerProcess");
const elixirSenseClient_1 = require("./elixirSenseClient");
const elixirSenseAutocompleteProvider_1 = require("./elixirSenseAutocompleteProvider");
const elixirSenseDefinitionProvider_1 = require("./elixirSenseDefinitionProvider");
const elixirSenseHoverProvider_1 = require("./elixirSenseHoverProvider");
const elixirSenseSignatureHelpProvider_1 = require("./elixirSenseSignatureHelpProvider");
const ELIXIR_MODE = { language: 'elixir', scheme: 'file' };
let elixirServer;
//Elixir-Sense
let useElixirSense;
let elixirSenseServer;
let elixirSenseClient;
function activate(ctx) {
    let elixirSetting = vscode.workspace.getConfiguration('elixir');
    useElixirSense = elixirSetting.useElixirSense;
    if (useElixirSense) {
        elixirSenseServerProcess_1.ElixirSenseServerProcess.initClass();
        //TODO: detect environment automatically.
        let env = elixirSetting.elixirEnv;
        let projectPath = vscode.workspace.rootPath;
        elixirSenseServer = new elixirSenseServerProcess_1.ElixirSenseServerProcess(vscode.workspace.rootPath, function (host, port, auth_token) {
            elixirSenseClient = new elixirSenseClient_1.ElixirSenseClient(host, port, auth_token, env, projectPath);
            ctx.subscriptions.push(vscode.languages.registerCompletionItemProvider(ELIXIR_MODE, new elixirSenseAutocompleteProvider_1.ElixirSenseAutocompleteProvider(elixirSenseClient), '.', '{', '@'));
            ctx.subscriptions.push(vscode.languages.registerDefinitionProvider(ELIXIR_MODE, new elixirSenseDefinitionProvider_1.ElixirSenseDefinitionProvider(elixirSenseClient)));
            ctx.subscriptions.push(vscode.languages.registerHoverProvider(ELIXIR_MODE, new elixirSenseHoverProvider_1.ElixirSenseHoverProvider(elixirSenseClient)));
            ctx.subscriptions.push(vscode.languages.registerSignatureHelpProvider(ELIXIR_MODE, new elixirSenseSignatureHelpProvider_1.ElixirSenseSignatureHelpProvider(elixirSenseClient), '(', ','));
            ctx.subscriptions.push(vscode.languages.setLanguageConfiguration('elixir', elixirConfiguration_1.configuration));
        });
        elixirSenseServer.start(0, env);
    }
    else {
        this.elixirServer = new elixirServer_1.ElixirServer();
        this.elixirServer.start();
        ctx.subscriptions.push(vscode.languages.registerCompletionItemProvider(ELIXIR_MODE, new elixirAutocomplete_1.ElixirAutocomplete(this.elixirServer), '.'));
        ctx.subscriptions.push(vscode.languages.registerDefinitionProvider(ELIXIR_MODE, new elixirDefinitionProvider_1.ElixirDefinitionProvider(this.elixirServer)));
        ctx.subscriptions.push(vscode.languages.registerHoverProvider(ELIXIR_MODE, new elixirHoverProvider_1.ElixirHoverProvider(this.elixirServer)));
        ctx.subscriptions.push(vscode.languages.setLanguageConfiguration('elixir', elixirConfiguration_1.configuration));
    }
}
exports.activate = activate;
function deactivate() {
    if (useElixirSense) {
        elixirSenseServer.stop();
    }
    else {
        this.elixirServer.stop();
    }
}
exports.deactivate = deactivate;
//# sourceMappingURL=elixirMain.js.map