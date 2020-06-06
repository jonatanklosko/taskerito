import React from 'react';
import logo from './logo.svg';
import { Switch, Route, Redirect } from 'react-router-dom';
import { Typography, Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignIn from './SignIn';
import SignUp from './SignUp';

const useStyles = makeStyles((theme) => ({
  root: {
    padding: theme.spacing(2),
    height: '100vh',
  },
  rootGrid: {
    height: '100%',
  },
  titleTypography: {
    fontFamily: 'Indie Flower',
  },
  logo: {
    height: '48px',
  },
  content: {
    padding: theme.spacing(3),
  },
}));

function Navigation() {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <Grid container spacing={1} alignItems="center">
        <Grid item>
          <img src={logo} alt="logo" className={classes.logo} />
        </Grid>
        <Grid item>
          <Typography
            variant="h3"
            className={classes.titleTypography}
            align="center"
          >
            Taskerito
          </Typography>
        </Grid>
      </Grid>
      <div className={classes.content}>
        <Switch>
          <Route exact path="/sign-in">
            <SignIn />
          </Route>
          <Route exact path="/sign-up">
            <SignUp />
          </Route>
          <Redirect to="/" />
        </Switch>
      </div>
    </div>
  );
}

export default Navigation;
