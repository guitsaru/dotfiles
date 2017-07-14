"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class ElixirSenseHoverProvider {
    constructor(elixirSenseClient) {
        this.elixirSenseClient = elixirSenseClient;
    }
    provideHover(document, position, token) {
        return new Promise((resolve, reject) => {
            if (!this.elixirSenseClient) {
                console.log("ElixirSense client not ready");
                console.error('rejecting');
                reject();
                return;
            }
            this.elixirSenseClient.send("docs", { buffer: document.getText(), line: position.line + 1, column: position.character + 1 }, result => {
                if (token.isCancellationRequested) {
                    console.error('rejecting');
                    reject();
                    return;
                }
                let { actual_subject, docs } = result;
                if (!docs) {
                    console.error('rejecting');
                    reject();
                    return;
                }
                const wordAtPosition = document.getWordRangeAtPosition(position);
                const hover = new vscode.Hover(docs.docs, wordAtPosition);
                resolve(hover);
            });
        });
    }
}
exports.ElixirSenseHoverProvider = ElixirSenseHoverProvider;
//# sourceMappingURL=elixirSenseHoverProvider.js.map