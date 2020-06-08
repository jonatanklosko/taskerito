import React from 'react';
import { useHistory, useParams } from 'react-router-dom';
import { useQuery, useMutation, gql } from '@apollo/client';
import taskImage from '../TaskForm/task.svg';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';
import Loading from '../Loading/Loading';
import TaskForm from '../TaskForm/TaskForm';

const TASK = gql`
  query Task($id: ID!) {
    task(id: $id) {
      id
      name
      description
      priority
    }
  }
`;

const UPDATE_TASK = gql`
  mutation UpdateTask($id: ID!, $input: TaskInput!) {
    updateTask(id: $id, input: $input) {
      successful
      result {
        id
        name
        description
        priority
      }
    }
  }
`;

function EditTask() {
  const { id } = useParams();
  const history = useHistory();

  const [updateTask, updateTaskState] = useMutation(UPDATE_TASK, {
    onCompleted: ({ updateTask: { successful } }) => {
      if (successful) {
        history.push(`/tasks/${id}`);
      }
    },
  });

  const { data, loading, error } = useQuery(TASK, { variables: { id } });

  if (error) return 'Something went wrong.';
  if (loading) return <Loading />;
  const { task } = data;

  return (
    <CenteredFormContainer svgImage={taskImage} title={`Edit - ${task.name}`}>
      <TaskForm
        initialData={task}
        disabled={updateTaskState.loading}
        failed={
          updateTaskState.data && !updateTaskState.data.updateTask.successful
        }
        onSubmit={(data) => updateTask({ variables: { id, input: data } })}
      />
    </CenteredFormContainer>
  );
}

export default EditTask;
