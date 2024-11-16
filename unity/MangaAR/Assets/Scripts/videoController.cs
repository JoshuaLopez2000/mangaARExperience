using UnityEngine;
using Vuforia;
using UnityEngine.Video;
using TMPro;

public class VideoPlayback : MonoBehaviour
{
    private ObserverBehaviour mObserverBehaviour;
    public VideoPlayer videoPlayer;
    public Renderer quadRenderer; // Quad que contiene el material inicial y el video
    public string videoFileName = "your_video.mp4"; // Nombre del archivo en StreamingAssets
    private bool isPrepared = false; // Bandera para controlar el estado del video
    private bool isTracked = false; // Bandera para rastrear el estado del ImageTarget

    //Swipe
    public string desiredDirection = "derecha"; // Puede ser "arriba", "abajo", "izquierda", "derecha"
    private Vector2 startTouchPosition, endTouchPosition;
    private bool swipeDetected = false;
    public float swipeThreshold = 50f; // Distancia mínima en píxeles para considerar un swipe

    //fRAME
    public GameObject frameImage;
    public GameObject hintImage;

    private Vector3 originalScale;





    void Start()
    {
        // Vincula el evento de cambio de estado del ImageTarget

        originalScale = frameImage.transform.localScale;

        mObserverBehaviour = GetComponent<ObserverBehaviour>();
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged += OnTargetStatusChanged;
        }

        // Configura la ruta del video desde StreamingAssets
        string videoPath = System.IO.Path.Combine(Application.streamingAssetsPath, videoFileName);
        videoPlayer.url = videoPath;

        PrepareVideo();
    }

    void Update()
    {
        DetectSwipe();

        float scaleFactor = Mathf.PingPong(Time.time * 0.2f, 0.2f) + 0.9f;
        hintImage.transform.localScale = originalScale * scaleFactor;

    }

    private void DetectSwipe()
    {
        if (Input.touchCount == 1)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                // Al comenzar el toque, registra la posición inicial
                startTouchPosition = touch.position;
            }
            else if (touch.phase == TouchPhase.Ended)
            {
                // Al terminar el toque, registra la posición final
                endTouchPosition = touch.position;

                // Calcula la distancia del swipe
                Vector2 swipeDelta = endTouchPosition - startTouchPosition;

                // Verifica si el swipe es lo suficientemente largo para considerarlo válido
                if (swipeDelta.magnitude >= swipeThreshold)
                {
                    swipeDetected = true;
                    CheckSwipeDirection(swipeDelta);
                }
            }
        }
    }

    private void CheckSwipeDirection(Vector2 swipeDelta)
    {
        if (Mathf.Abs(swipeDelta.x) > Mathf.Abs(swipeDelta.y))
        {
            // Swipe horizontal
            if (swipeDelta.x > 0)
            {
                Debug.Log("Swipe Detectado: Derecha");
                if (desiredDirection == "derecha")
                {
                    OnSwipeDetected();
                }
            }
            else
            {
                Debug.Log("Swipe Detectado: Izquierda");
                if (desiredDirection == "izquierda")
                {
                    OnSwipeDetected();
                }
            }
        }
        else
        {
            // Swipe vertical
            if (swipeDelta.y > 0)
            {
                Debug.Log("Swipe Detectado: Arriba");
                if (desiredDirection == "arriba")
                {
                    OnSwipeDetected();
                }
            }
            else
            {
                Debug.Log("Swipe Detectado: Abajo");
                if (desiredDirection == "abajo")
                {
                    OnSwipeDetected();
                }
            }
        }
    }
    private void OnSwipeDetected()
    {
        frameImage.SetActive(false);
        Debug.Log("Swipe en la dirección deseada detectado: " + desiredDirection);
        if (isTracked) {
            DisableHints();
            videoPlayer.Play();

        }
    }



    private void OnDestroy()
    {
        // Desvincula el evento al destruir el objeto
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged -= OnTargetStatusChanged;
        }
    }

    private void PrepareVideo()
    {
        if (!isPrepared)
        {
            videoPlayer.Prepare();
            videoPlayer.prepareCompleted += OnVideoPrepared;
        }
    }

    private void OnTargetStatusChanged(ObserverBehaviour behaviour, TargetStatus targetStatus)
    {
        isTracked = (targetStatus.Status == Status.TRACKED);

        if (isTracked)
        {
            EnableHints();
            PrepareVideo();
        }
        else
        {
            if (videoPlayer.isPlaying)
            {
                DisableHints();
                videoPlayer.Stop();
                isPrepared = false;
            }
        }
    }

    private void OnVideoPrepared(VideoPlayer vp)
    {
        Debug.Log("Video preparado y listo para reproducirse");
        isPrepared = true;
        EnableHints();
    }

    private void DisableHints() {
        frameImage.SetActive(false);
        hintImage.SetActive(false);
    }

    private void EnableHints() {
        frameImage.SetActive(true);
        hintImage.SetActive(true);
    }
}