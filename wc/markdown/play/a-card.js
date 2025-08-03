class Card extends HTMLElement {
  constructor() {
    super()
    const shadow = this.attachShadow({ mode: 'open' })
    shadow.innerHTML = `
      <style>
        :host {
          display: block;
          border: 0.5px solid black;
          padding: 0.5rem 1rem;
          border-radius: 8px;
          box-shadow: 0 1px 4px 0 rgba(0,0,0,0.08);
        }
        :host(.variant-2) {
          box-shadow: 0 1px 4px 0 rgba(0,0,0,0.08);
        }
        ::slotted(h1) {
          font-size: large;
        }
        ::slotted(p) {
          font-size: small;
          opacity: 0.5;
        }
      </style>
      <slot></slot>
    `
  }
}

customElements.define('a-card', Card)