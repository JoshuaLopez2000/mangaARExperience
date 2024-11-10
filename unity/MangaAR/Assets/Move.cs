using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using Vuforia;
using UnityEngine.SceneManagement;

public class Move : MonoBehaviour
{
    public GameObject model;
    public List<TargetInfo> ImageTargets;
    public float speed = 1.0f;
    public TMP_Text gameMessage;
    private bool isMoving = false;
    private int currentTargetIndex = 0;
    private bool gameLost = false;
    private int maxCount = 0;

    [System.Serializable]
    public class TargetInfo
    {
        public ObserverBehaviour target;
        public int targetOrder;
    }

    public void moveToNextMarker()
    {
        if (!isMoving && ImageTargets.Count > 0)
        {
            ObserverBehaviour target = GetClosestDetectedTarget();
            if (target == null)
            {
                ShowMessage("No hay targets detectados.");
                return;
            }

            StartCoroutine(MoveModel(target));
        }
    }

    private IEnumerator MoveModel(ObserverBehaviour target)
    {
        if (currentTargetIndex == 0)
        {
            maxCount = ImageTargets.Count;
        }

        if (!gameLost)
        {
            isMoving = true;
            ShowMessage("");

            Vector3 startPosition = model.transform.position;
            Vector3 endPosition = target.transform.position;

            float journey = 0;
            while (journey <= 1.0f)
            {
                journey += Time.deltaTime * speed;
                model.transform.position = Vector3.Lerp(startPosition, endPosition, journey);
                yield return null;
            }

            // Asignar el nuevo padre.
            model.transform.SetParent(target.transform, true);

            // Comprobar si el target al que se movió es el siguiente en el orden.
            bool isCorrectTarget = ImageTargets.Exists(t => t.target == target && t.targetOrder == currentTargetIndex);

            if (!isCorrectTarget)
            {
                ShowMessage("Perdiste");
                gameLost = true;
            }
            else
            {
                currentTargetIndex++;
                ImageTargets.RemoveAll(t => t.target == target);
            }

            isMoving = false;

            if (currentTargetIndex >= maxCount)
            {
                ShowMessage("¡Ganaste!");
            }
        }
        else {
            ResetGame();
        }
    }

    private void ResetGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    private ObserverBehaviour GetClosestDetectedTarget()
    {
        List<TargetInfo> detectedTargets = new List<TargetInfo>();

        // Buscar todos los targets que están siendo detectados.
        foreach (TargetInfo targetInfo in ImageTargets)
        {
            if (targetInfo.target.TargetStatus.Status == Status.TRACKED ||
                targetInfo.target.TargetStatus.Status == Status.EXTENDED_TRACKED)
            {
                detectedTargets.Add(targetInfo);
            }
        }

        // Retornar el target más cercano si hay alguno.
        if (detectedTargets.Count > 0)
        {
            return GetClosestTarget(detectedTargets);
        }

        return null;
    }

    private ObserverBehaviour GetClosestTarget(List<TargetInfo> detectedTargets)
    {
        ObserverBehaviour closestTarget = null;
        float closestDistance = Mathf.Infinity;
        Vector3 modelPosition = model.transform.position;

        foreach (TargetInfo targetInfo in detectedTargets)
        {
            float distance = Vector3.Distance(modelPosition, targetInfo.target.transform.position);
            if (distance < closestDistance)
            {
                closestDistance = distance;
                closestTarget = targetInfo.target;
            }
        }

        return closestTarget;
    }

    // Función para mostrar un mensaje en el UI TMP_Text.
    private void ShowMessage(string message)
    {
        if (gameMessage != null)
        {
            gameMessage.text = message;
        }
    }
}
