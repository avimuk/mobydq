import React from 'react';
import ReactDOM from 'react-dom';
import Dashboard from './Components/Dashboard/Dashboard';

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<App />, div);
  ReactDOM.unmountComponentAtNode(div);
});
