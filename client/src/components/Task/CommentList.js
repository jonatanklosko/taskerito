import React from 'react';
import { Grid, Paper, Typography } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import discussionImage from './discussion.svg';
import { formatDateTime } from '../../lib/date';
import DeleteCommentButton from './DeleteCommentButton';

const useStyles = makeStyles((theme) => ({
  comment: {
    padding: theme.spacing(2),
  },
}));

function CommentList({ comments, refetchQueries = [] }) {
  const classes = useStyles();

  if (comments.length === 0) {
    return <img src={discussionImage} alt="No comments yet." height="128" />;
  }

  return (
    <Grid container direction="column" spacing={2}>
      {comments.map((comment) => (
        <Grid item key={comment.id}>
          <Paper className={classes.comment}>
            <Grid container alignItems="center" spacing={1}>
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
              {comment.canManage && (
                <Grid item>
                  <DeleteCommentButton
                    id={comment.id}
                    refetchQueries={refetchQueries}
                  />
                </Grid>
              )}
            </Grid>
            <Typography>{comment.content}</Typography>
          </Paper>
        </Grid>
      ))}
    </Grid>
  );
}

export default CommentList;
