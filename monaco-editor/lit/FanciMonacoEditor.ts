import { LitElement, html, css } from 'lit';

export class FanciMonacoEditor extends LitElement {
  static styles = css`p { 
    color: #fafafa; 
    font-size: 25px;
    font-family: Inter;
  }`;

  render() {
    return html`<p>Hello from FanciMonacoEditor!</p>`;
  }
}

customElements.define('fanci-monaco-editor', FanciMonacoEditor);