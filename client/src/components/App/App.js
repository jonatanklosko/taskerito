import React from 'react';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import { CssBaseline } from '@material-ui/core';
import { createMuiTheme, ThemeProvider } from '@material-ui/core/styles';
import {
  ApolloClient,
  HttpLink,
  InMemoryCache,
  ApolloProvider,
} from '@apollo/client';

import Home from '../Home/Home';
import Navigation from '../Navigation/Navigation';

const theme = createMuiTheme({
  palette: {
    primary: {
      light: '#5ff39c',
      main: '#13bf6d',
      dark: '#008d41',
      contrastText: '#fff',
    },
    secondary: {
      light: '#484848',
      main: '#212121',
      dark: '#000000',
      contrastText: '#fff',
    },
  },
});

const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: new HttpLink({
    uri:
      process.env.NODE_ENV === 'production'
        ? '/api'
        : 'http://localhost:4000/api',
  }),
});

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
