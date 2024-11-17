using UnityEngine;
using Vuforia;
using UnityEngine.Video;

public class videoOnTaps : MonoBehaviour
{
    private ObserverBehaviour mObserverBehaviour;
    public VideoPlayer videoPlayer;
    public Renderer quadRenderer;
    public string videoFileName = "your_video.mp4";
    private bool isPrepared = false;
    private bool isTracked = false;

    // Tap detection
    private int tapCount = 0;
    private float tapStartTime = 0f;
    public float tapTimeLimit = 5f; // Tiempo límite en segundos para detectar 10 taps

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
        DetectTaps();

        float scaleFactor = Mathf.PingPong(Time.time * 1.0f, 0.2f) + 0.9f;
        hintImage.transform.localScale = originalScale * scaleFactor;
    }

    private void DetectTaps()
    {
        if (Input.touchCount == 1)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Ended)
            {
                // Inicia el conteo de taps
                if (tapCount == 0)
                {
                    tapStartTime = Time.time;
                }

                tapCount++;

                Debug.Log($"Tap #{tapCount} detectado");

                // Verifica si se han realizado 10 taps dentro del tiempo límite
                if (tapCount >= 10)
                {
                    if (Time.time - tapStartTime <= tapTimeLimit)
                    {
                        OnTapsDetected();
                    }
                    else
                    {
                        Debug.Log("Tiempo excedido para los 10 taps. Reiniciando contador.");
                        ResetTapCount();
                    }
                }
            }
        }

        // Reinicia el contador si el tiempo límite expira
        if (tapCount > 0 && Time.time - tapStartTime > tapTimeLimit)
        {
            Debug.Log("Tiempo límite para taps excedido. Reiniciando contador.");
            ResetTapCount();
        }
    }

    private void ResetTapCount()
    {
        tapCount = 0;
        tapStartTime = 0f;
    }

    private void OnTapsDetected()
    {
        Debug.Log("Se detectaron 10 taps dentro del tiempo límite. Reproduciendo video.");
        ResetTapCount();
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
