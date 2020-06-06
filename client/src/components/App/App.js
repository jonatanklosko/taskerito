import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { CssBaseline } from '@material-ui/core';
import { ThemeProvider } from '@material-ui/core/styles';
import { ApolloProvider } from '@apollo/client';
import { client } from './apollo';
import { theme } from './theme';

import Home from '../Home/Home';
import Navigation from '../Navigation/Navigation';

function App() {
  return (
    <ThemeProvider theme={theme}>
      <Router>
        <ApolloProvider client={client}>
          <CssBaseline />
          <Switch>
            <Route exact path="/">
              <Home />
            </Route>
            <Route path="/">
              <Navigation />
            </Route>
          </Switch>
        </ApolloProvider>
      </Router>
    </ThemeProvider>
  );
}

export default App;
