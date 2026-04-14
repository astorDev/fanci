import { LitElement, html, css } from 'lit';

export class MyElement extends LitElement {
  static styles = css`p { 
    color: #fafafa; 
    font-size: 25px;
    font-family: Inter;
  }`;

  render() {
    return html`<p>Hello from Lit!</p>`;
  }
}

customElements.define('my-element', MyElement);