using UnityEngine;
using Vuforia;
using UnityEngine.Video;

public class videoOnTwoSwipesController : MonoBehaviour
{
    private ObserverBehaviour mObserverBehaviour;
    public VideoPlayer videoPlayer;
    public Renderer quadRenderer;
    public string videoFileName = "your_video.mp4";
    private bool isPrepared = false;
    private bool isTracked = false;

    // Swipe
    public string desiredFirstSwipe = "derecha"; // Primer swipe deseado
    public string desiredSecondSwipe = "izquierda"; // Segundo swipe deseado
    private Vector2 startTouchPosition, endTouchPosition;
    private bool firstSwipeDetected = false;
    private float swipeThreshold = 50f; // Distancia mínima en píxeles para considerar un swipe
    private float swipeTimeout = 1.0f; // Tiempo máximo entre swipes en segundos
    private float lastSwipeTime;

    // Hints
    public GameObject frameImage;
    public GameObject hintImage;
    private Vector3 originalScale;

    void Start()
    {
        originalScale = frameImage.transform.localScale;

        mObserverBehaviour = GetComponent<ObserverBehaviour>();
        if (mObserverBehaviour)
        {
            mObserverBehaviour.OnTargetStatusChanged += OnTargetStatusChanged;
        }

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
                startTouchPosition = touch.position;
            }
            else if (touch.phase == TouchPhase.Ended)
            {
                endTouchPosition = touch.position;

                Vector2 swipeDelta = endTouchPosition - startTouchPosition;

                if (swipeDelta.magnitude >= swipeThreshold)
                {
                    CheckSwipeDirection(swipeDelta);
                }
            }
        }
    }

    private void CheckSwipeDirection(Vector2 swipeDelta)
    {
        string swipeDirection = "";

        if (Mathf.Abs(swipeDelta.x) > Mathf.Abs(swipeDelta.y))
        {
            // Swipe horizontal
            swipeDirection = swipeDelta.x > 0 ? "derecha" : "izquierda";
        }
        else
        {
            // Swipe vertical
            swipeDirection = swipeDelta.y > 0 ? "arriba" : "abajo";
        }

        ProcessSwipe(swipeDirection);
    }

    private void ProcessSwipe(string swipeDirection)
    {
        if (!firstSwipeDetected)
        {
            // Verifica el primer swipe
            if (swipeDirection == desiredFirstSwipe)
            {
                firstSwipeDetected = true;
                lastSwipeTime = Time.time;
                Debug.Log("Primer swipe detectado: " + swipeDirection);
            }
        }
        else
        {
            // Verifica el segundo swipe dentro del tiempo permitido
            if (Time.time - lastSwipeTime <= swipeTimeout)
            {
                if (swipeDirection == desiredSecondSwipe)
                {
                    Debug.Log("Segundo swipe detectado: " + swipeDirection);
                    OnDoubleSwipeDetected();
                }
                else
                {
                    Debug.Log("Swipe incorrecto: " + swipeDirection);
                }
            }
            else
            {
                Debug.Log("Tiempo excedido para el segundo swipe");
            }

            // Reinicia el estado
            firstSwipeDetected = false;
        }
    }

    private void OnDoubleSwipeDetected()
    {
        Debug.Log("Secuencia de swipes correcta detectada: " + desiredFirstSwipe + " y " + desiredSecondSwipe);
        frameImage.SetActive(false);

        if (isTracked)
        {
            DisableHints();
            videoPlayer.Play();
        }
    }

    private void OnDestroy()
    {
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

    private void DisableHints()
    {
        frameImage.SetActive(false);
        hintImage.SetActive(false);
    }

    private void EnableHints()
    {
        frameImage.SetActive(true);
        hintImage.SetActive(true);
    }
}
