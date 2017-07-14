"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const path = require("path");
const vscode = require("vscode");
class ElixirSenseServerProcess {
    constructor(projectPath, onTcpServerReady) {
        this.projectPath = projectPath;
        this.onTcpServerReady = onTcpServerReady;
        this.command = "elixir";
        let extensionPath = vscode.extensions.getExtension("mjmcloug.vscode-elixir").extensionPath;
        this.args = [path.join(extensionPath, "elixir_sense/run.exs")];
        this.proc = null;
    }
    static initClass() {
        this.prototype.ready = false;
        this.prototype.proc = null;
    }
    start(port, env) {
        this.proc = this.spawnChildProcess(port, env);
        this.proc.stdout.on('data', chunk => {
            if (this.onTcpServerReady) {
                let auth_token, host;
                if (~chunk.indexOf("ok:")) {
                    let _;
                    let rst = chunk.toString();
                    [_, host, port, auth_token] = Array.from(chunk.toString().split(":"));
                }
                this.onTcpServerReady(host, port, auth_token || null);
                this.onTcpServerReady = null;
                return;
            }
            console.log(`[ElixirSense] ${chunk.toString()}`);
            return this.ready = true;
        });
        this.proc.stderr.on('data', chunk => {
            this.ready = true;
            let message = `[ElixirSense] ${chunk.toString()}`;
            if (~chunk.indexOf("Server Error")) {
                return console.warn(message);
            }
            else {
                return console.log(message);
            }
        });
        this.proc.on('close', exitCode => {
            console.log(`[vscode-elixir] Child process exited with code ${exitCode}`);
            this.ready = false;
            return this.proc = null;
        });
        return this.proc.on('error', error => {
            console.error(`[vscode-elixir] ${error.toString()}`);
            this.ready = false;
            return this.proc = null;
        });
    }
    stop() {
        this.proc.stdin.end();
        this.ready = false;
        return this.proc = null;
    }
    spawnChildProcess(port, env) {
        let options = {
            cwd: this.projectPath,
            stdio: "pipe",
            windowsVerbatimArguments: false
        };
        if (process.platform === 'win32') {
            options.windowsVerbatimArguments = true;
            return child_process_1.spawn('cmd', ['/s', '/c', `"${[this.command].concat(this.args).concat('tcpip', port, env).join(' ')}"`], options);
        }
        else {
            return child_process_1.spawn(this.command, this.args.concat('unix', port, env), options);
        }
    }
}
exports.ElixirSenseServerProcess = ElixirSenseServerProcess;
//# sourceMappingURL=elixirSenseServerProcess.js.map