import React from 'react';
import { gql, useMutation } from '@apollo/client';
import { Chip } from '@material-ui/core';

const UNASSIGN_TASK = gql`
  mutation UnassignTask($id: ID!, $userId: ID!) {
    unassignTask(id: $id, userId: $userId) {
      successful
      result {
        id
        assignees {
          id
          username
        }
      }
    }
  }
`;

function AssigneeChip({ taskId, assignee, canManage }) {
  const [unassignTask, { loading }] = useMutation(UNASSIGN_TASK, {
    variables: { id: taskId, userId: assignee.id },
  });

  function handleUnassign() {
    unassignTask();
  }

  return (
    <Chip
      key={assignee.id}
      size="small"
      label={`@${assignee.username}`}
      variant="outlined"
      color="primary"
      onDelete={canManage ? handleUnassign : undefined}
      disabled={loading}
    />
  );
}

export default AssigneeChip;
