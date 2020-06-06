import React from 'react';
import { Typography, Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
  image: {
    height: 128,
    maxWidth: '100%',
  },
  content: {
    minWidth: '40%',
    [theme.breakpoints.down('sm')]: {
      minWidth: '100%',
    },
  },
  formContainer: {
    width: '100%',
  },
}));

function CenteredFormContainer({ svgImage, title, children }) {
  const classes = useStyles();

  return (
    <Grid container direction="column" spacing={3} alignItems="center">
      {svgImage && (
        <Grid item>
          <img src={svgImage} alt="" className={classes.image} />
        </Grid>
      )}
      <Grid item className={classes.content}>
        <Grid container direction="column" alignItems="flex-start" spacing={2}>
          <Grid item>
            <Typography variant="h5">{title}</Typography>
          </Grid>
          <Grid item className={classes.formContainer}>
            {children}
          </Grid>
        </Grid>
      </Grid>
    </Grid>
  );
}

export default CenteredFormContainer;
