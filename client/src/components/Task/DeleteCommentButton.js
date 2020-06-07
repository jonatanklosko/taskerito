import React from 'react';
import { gql, useMutation } from '@apollo/client';
import { IconButton } from '@material-ui/core';
import DeleteIcon from '@material-ui/icons/Delete';
import { useConfirm } from 'material-ui-confirm';

const DELETE_COMMENT = gql`
  mutation DeleteComment($id: ID!) {
    deleteComment(id: $id) {
      successful
    }
  }
`;

function DeleteCommentButton({ id, refetchQueries = [] }) {
  const confirm = useConfirm();
  const [createComment, { loading }] = useMutation(DELETE_COMMENT, {
    variables: { id },
    refetchQueries,
  });

  function handleDeleteClick() {
    confirm({ description: 'This will permanently delete this comment.' })
      .then(() => createComment())
      .catch(() => {});
  }

  return (
    <IconButton size="small" onClick={handleDeleteClick} disabled={loading}>
      <DeleteIcon />
    </IconButton>
  );
}

export default DeleteCommentButton;
