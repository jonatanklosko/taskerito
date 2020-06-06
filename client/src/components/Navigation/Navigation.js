import React from 'react';
import { useQuery, gql } from '@apollo/client';
import logo from '../Home/logo.svg';
import { Switch, Route, Redirect } from 'react-router-dom';
import { Typography, Grid, Toolbar, LinearProgress } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignIn from '../SignIn/SignIn';
import SignUp from '../SignUp/SignUp';
import SignOutButton from './SignOutButton';

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
  grow: {
    flexGrow: 1,
  },
}));

const CURRENT_USER = gql`
  query CurrentUser {
    currentUser {
      id
      name
    }
  }
`;

function Navigation() {
  const classes = useStyles();
  const { data, loading, error } = useQuery(CURRENT_USER);

  if (error) return 'Something went wrong.';
  if (loading) return <LinearProgress />;
  const { currentUser } = data;

  return (
    <>
      <Toolbar>
        <Grid container alignItems="center">
          <Grid item>
            <img src={logo} alt="logo" className={classes.logo} />
          </Grid>
          <Grid item className={classes.grow}>
            <Typography variant="h3" className={classes.titleTypography}>
              Taskerito
            </Typography>
          </Grid>
          {currentUser && <SignOutButton />}
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
