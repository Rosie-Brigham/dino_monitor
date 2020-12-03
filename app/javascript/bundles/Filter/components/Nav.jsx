import React from 'react';
import Logo from 'images/logo-2019-inverted.png'
import SquareLogo from 'images/main-logo-black-squished.jpg'

import Key from './Key.jsx'
import Form from './Form.jsx'
import Login from './Login.jsx'

export default class Nav extends React.Component {
  constructor(props) {
    super(props);
    this.state = {     
      collapsed: false,
    }

  }

  // this is really hacky and bad, but I'm really tired.
  toggleNav = () => {
    this.setState({collapsed: !this.state.collapsed});
    this.props.handleToggleNav()
  }

  
  render() {
    const {collapsed} = this.state
    return (
      <nav className={collapsed ? "collapsed" : "full"}>
        <img src={collapsed ? SquareLogo : Logo} onClick={this.toggleNav} className="pointer"/>
        {collapsed ? (
          // collapsed nav
              <div className="nav-content"></div>
        ) : (
          // normal nav
          <div className="nav-content">
            <div className="mb5">
              <button 
                className={this.props.viewDataVis ? "w-50 br--left active-button" : "w-50 br--left"} 
                onClick={this.props.handleToggle}>Data</button>
              <button 
                className={this.props.viewDataVis ? "w-50 br--right white" : "w-50 br--right active-button"} 
                onClick={this.props.handleToggle}>Images</button>
            </div>
            <Form groupNames={this.props.groupNames} tags={this.props.tags} refineView={this.props.refineView} email={this.props.userEmail}/>
            <div className='w-100 absolute-ns bottom-0-ns'>
              <Login userEmail={this.props.userEmail} />
              <Key />
            </div>
          </div>
        )}

      </nav>
    )
  }
}