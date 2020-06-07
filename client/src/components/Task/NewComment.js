import React, { useState } from 'react';
import { useMutation, gql } from '@apollo/client';
import { TextField, Button, Grid } from '@material-ui/core';

const CREATE_COMMENT = gql`
  mutation CreateComment($taskId: ID!, $input: CommentInput!) {
    createComment(taskId: $taskId, input: $input) {
      successful
      result {
        id
      }
    }
  }
`;

function NewComment({ taskId, refetchQueries }) {
  const [content, setContent] = useState('');
  const [createComment, { loading }] = useMutation(CREATE_COMMENT, {
    variables: { taskId, input: { content } },
    onCompleted: ({ createComment: { successful, result } }) => {
      if (successful) {
        setContent('');
      }
    },
    refetchQueries,
  });

  return (
    <Grid container direction="column" spacing={1}>
      <Grid item>
        <TextField
          fullWidth
          multiline
          variant="outlined"
          placeholder="Write something..."
          value={content}
          onChange={(event) => setContent(event.target.value)}
        />
      </Grid>
      <Grid item>
        <Button
          variant="contained"
          disableElevation
          color="primary"
          disabled={content === '' || loading}
          onClick={() => createComment()}
        >
          Submit
        </Button>
      </Grid>
    </Grid>
  );
}

export default NewComment;
