import React from 'react';
import { Grid, Paper, Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import { formatDateTime } from '../../lib/date';

const useStyles = makeStyles((theme) => ({
  comment: {
    padding: theme.spacing(2),
  },
}));

function CommentList({ comments }) {
  const classes = useStyles();

  return (
    <Grid container direction="column" spacing={2}>
      {comments.map((comment) => (
        <Grid item key={comment.id}>
          <Paper className={classes.comment}>
            <Grid container alignItems="center">
              <Grid item xs>
                <Typography
                  variant="subtitle1"
                  color="textSecondary"
                  gutterBottom
                >
                  @{comment.author.username}
                </Typography>
              </Grid>
              <Grid item>{formatDateTime(comment.insertedAt)}</Grid>
            </Grid>
            <Typography>{comment.content}</Typography>
          </Paper>
        </Grid>
      ))}
    </Grid>
  );
}

export default CommentList;
