import React from 'react';

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = {
      site: '',
      type: '',
      reliable: false
    }
  }

  handleSubmit = event => {
    event.preventDefault()
    this.props.refineView(this.state.reliable, this.state.site, this.state.type)
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.id;
    
    this.setState({
      [name]: value
    });
  }
  
  render() {
    return (
      <form className="ph4 pv3 green-background br1" onSubmit={this.handleSubmit}>
          <div className="flex flex-wrap items-center justify-between">
            <span className="h-25">
              <label>
                Useful?
              </label>
              <input
                name="useful"
                id="reliable"
                type="checkbox"
                checked={this.state.reliable}
                onChange={this.handleInputChange} />
            </span>

            <span className="h-25">
              <label>
                Site:
              </label>
              <input 
                type="text" 
                id="site" 
                value={this.state.site} 
                onChange={this.handleInputChange} />
            </span>

            <span className="h-25">
              <label>
                Type:
              </label>
              <input 
                type="text" 
                id="type" 
                value={this.state.type} 
                onChange={this.handleInputChange} />
            </span>
          </div>
          
          
          <button className="flex center mt4 white-background dark-color" type="submit" onClick={this.handleSubmit}>
            Search
          </button>
        </form>
    )
  }
}