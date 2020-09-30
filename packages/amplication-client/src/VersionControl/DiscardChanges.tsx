import React, { useCallback, useContext } from "react";
import { Snackbar } from "@rmwc/snackbar";

import { gql } from "apollo-boost";
import { useMutation } from "@apollo/react-hooks";
import { formatError } from "../util/error";
import { GET_PENDING_CHANGES } from "./PendingChanges";
import { Button, EnumButtonStyle } from "../Components/Button";
import PendingChangesContext from "../VersionControl/PendingChangesContext";
import "./DiscardChanges.scss";
import { ReactComponent as ImageWarning } from "../assets/images/warning.svg";

type Props = {
  applicationId: string;
  onComplete: () => void;
  onCancel: () => void;
};

const CLASS_NAME = "discard-changes";

const DiscardChanges = ({ applicationId, onComplete, onCancel }: Props) => {
  const pendingChangesContext = useContext(PendingChangesContext);

  const [discardChanges, { error, loading }] = useMutation(DISCARD_CHANGES, {
    onCompleted: (data) => {
      pendingChangesContext.reset();
      onComplete();
    },
    refetchQueries: [
      {
        query: GET_PENDING_CHANGES,
        variables: {
          applicationId: applicationId,
        },
      },
    ],
  });

  const handleConfirm = useCallback(() => {
    discardChanges({
      variables: {
        appId: applicationId,
      },
    }).catch(console.error);
  }, [applicationId, discardChanges]);

  const errorMessage = formatError(error);

  return (
    <div className={CLASS_NAME}>
      <div className={`${CLASS_NAME}__instructions`}>
        Are you sure you want to discard all pending changes? <br /> This action
        cannot be undone
      </div>

      <div className={`${CLASS_NAME}__buttons`}>
        <div className="spacer" />
        <Button buttonStyle={EnumButtonStyle.Clear} onClick={onCancel}>
          Cancel
        </Button>

        <Button
          buttonStyle={EnumButtonStyle.Primary}
          eventData={{
            eventName: "discardPendingChanges",
          }}
          onClick={handleConfirm}
          disabled={loading}
        >
          Discard Changes
        </Button>
      </div>

      <Snackbar open={Boolean(error)} message={errorMessage} />
    </div>
  );
};

export default DiscardChanges;

const DISCARD_CHANGES = gql`
  mutation discardChanges($appId: String!) {
    discardPendingChanges(data: { app: { connect: { id: $appId } } })
  }
`;
