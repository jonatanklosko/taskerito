import React from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { useMutation, gql } from '@apollo/client';
import taskImage from '../TaskForm/task.svg';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';
import TaskForm from '../TaskForm/TaskForm';

const CREATE_TASK = gql`
  mutation CreateTask($projectId: ID!, $input: TaskInput!) {
    createTask(projectId: $projectId, input: $input) {
      successful
      result {
        id
      }
    }
  }
`;

function NewTask() {
  const history = useHistory();
  const { projectId } = useParams();
  const [createTask, { data, loading }] = useMutation(CREATE_TASK, {
    onCompleted: ({ createTask: { successful, result } }) => {
      if (successful) {
        history.push(`/tasks/${result.id}`);
      }
    },
  });

  return (
    <CenteredFormContainer svgImage={taskImage} title="New task">
      <TaskForm
        submitText="Create"
        disabled={loading}
        failed={data && !data.createTask.successful}
        onSubmit={(data) =>
          createTask({ variables: { projectId, input: data } })
        }
      />
    </CenteredFormContainer>
  );
}

export default NewTask;
