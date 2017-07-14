"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class ElixirSenseDefinitionProvider {
    constructor(elixirSenseClient) {
        this.elixirSenseClient = elixirSenseClient;
    }
    provideDefinition(document, position, token) {
        const wordAtPosition = document.getWordRangeAtPosition(position);
        const word = document.getText(wordAtPosition);
        return new Promise((resolve, reject) => {
            if (!this.elixirSenseClient) {
                console.log("ElixirSense client not ready");
                console.error('rejecting');
                reject();
                return;
            }
            this.elixirSenseClient.send("definition", { buffer: document.getText(), line: position.line + 1, column: position.character + 1 }, result => {
                if (token.isCancellationRequested) {
                    console.error('rejecting');
                    reject();
                    return;
                }
                let [filePath, lineNumberStr] = result.split(':');
                let lineNumber = Number(lineNumberStr) - 1;
                if (!filePath || filePath == 'non_existing') {
                    resolve(null);
                    return;
                }
                let location;
                if (lineNumber >= 0) {
                    location = new vscode.Location(vscode.Uri.file(filePath), new vscode.Position(lineNumber, 0));
                }
                else {
                    location = new vscode.Location(vscode.Uri.file(filePath), new vscode.Position(0, 0));
                }
                resolve(location);
            });
        });
    }
}
exports.ElixirSenseDefinitionProvider = ElixirSenseDefinitionProvider;
//# sourceMappingURL=elixirSenseDefinitionProvider.js.map