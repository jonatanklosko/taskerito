import React from 'react';
import logo from '../Home/logo.svg';
import { Switch, Route, Redirect } from 'react-router-dom';
import { Typography, Grid, Toolbar } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignIn from '../SignIn/SignIn';
import SignUp from '../SignUp/SignUp';

const useStyles = makeStyles((theme) => ({
  titleTypography: {
    fontFamily: 'Indie Flower',
  },
  logo: {
    height: '48px',
    marginRight: theme.spacing(1),
  },
  content: {
    padding: theme.spacing(3),
  },
}));

function Navigation() {
  const classes = useStyles();

  return (
    <>
      <Toolbar>
        <Grid container alignItems="center">
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
      </Toolbar>
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
    </>
  );
}

export default Navigation;
