package com.example.pets_adoption.controller;

import com.example.pets_adoption.dto.R;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@RequestMapping("/common")
@Slf4j
public class FileDownUpController {

    @Value("${pets_adoption.file-path}")
    private String imagePath;

    private final ConcurrentHashMap<String, byte[]> imageCache = new ConcurrentHashMap<>();

    @GetMapping("/download")
    public void download(String name, HttpServletResponse response) {
        try {
            log.info("文件下载请求：{}", name);

            // 检查参数
            if (name == null || name.trim().isEmpty()) {
                log.warn("文件名为空");
                sendDefaultImage(response);
                return;
            }

            // ========== 关键修改：判断是否为网络URL ==========
            if (name.startsWith("http://") || name.startsWith("https://")) {
                log.info("处理网络URL图片：{}", name);
                handleNetworkImage(name, response);
                return;
            }
            // ==============================================

            // 原有的本地文件处理逻辑
            handleLocalFile(name, response);

        } catch (Exception e) {
            log.error("文件下载异常：{}", e.getMessage());
            sendDefaultImage(response);
        }
    }

    /**
     * 处理网络图片（新增方法）
     */
    private void handleNetworkImage(String url, HttpServletResponse response) {
        // 使用URL的hash作为缓存键
        String cacheKey = "url_" + url.hashCode();

        try {
            // 检查缓存
            byte[] cachedImage = imageCache.get(cacheKey);
            if (cachedImage != null) {
                log.info("从缓存获取网络图片：{}", url);
                writeToResponse(cachedImage, response, "image/jpeg");
                return;
            }

            // 下载网络图片
            log.info("开始下载网络图片：{}", url);
            URL imageUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) imageUrl.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(10000);
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
                try (InputStream input = conn.getInputStream();
                     ByteArrayOutputStream output = new ByteArrayOutputStream()) {

                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }

                    byte[] imageData = output.toByteArray();

                    // 缓存
                    if (imageCache.size() < 1000) {
                        imageCache.put(cacheKey, imageData);
                    }

                    // 获取内容类型
                    String contentType = conn.getContentType();
                    if (contentType == null || !contentType.startsWith("image/")) {
                        contentType = "image/jpeg";
                    }

                    // 写入响应
                    writeToResponse(imageData, response, contentType);

                    log.info("网络图片下载成功：{}，大小：{}字节", url, imageData.length);
                }
            } else {
                log.error("下载网络图片失败，状态码：{}", conn.getResponseCode());
                sendDefaultImage(response);
            }

            conn.disconnect();

        } catch (Exception e) {
            log.error("处理网络图片失败：{}", e.getMessage());
            sendDefaultImage(response);
        }
    }

    /**
     * 处理本地文件（原有逻辑）
     */
    private void handleLocalFile(String name, HttpServletResponse response) throws IOException {
        // 安全检查
        if (name.contains("..") || name.contains("/") || name.contains("\\")) {
            log.warn("非法文件名：{}", name);
            sendDefaultImage(response);
            return;
        }

        byte[] cachedImage = imageCache.get(name);
        if (cachedImage != null) {
            writeToResponse(cachedImage, response, "image/jpeg");
            return;
        }

        File imageFile = new File(imagePath + name);
        if (!imageFile.exists()) {
            log.warn("本地文件不存在：{}", name);
            sendDefaultImage(response);
            return;
        }

        byte[] image = FileUtils.readFileToByteArray(imageFile);
        if (imageCache.size() < 1000) {
            imageCache.put(name, image);
        }

        writeToResponse(image, response, getContentType(name));
    }

    /**
     * 写入响应流
     */
    private void writeToResponse(byte[] data, HttpServletResponse response, String contentType) throws IOException {
        response.setContentType(contentType);
        response.setHeader("Cache-Control", "max-age=300");
        response.setContentLength(data.length);

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            outputStream.write(data);
            outputStream.flush();
        }
    }

    /**
     * 发送默认图片
     */
    private void sendDefaultImage(HttpServletResponse response) {
        try {
            InputStream defaultStream = getClass().getResourceAsStream("/static/images/logo.jpg");
            if (defaultStream != null) {
                byte[] defaultImage = IOUtils.toByteArray(defaultStream);
                writeToResponse(defaultImage, response, "image/jpeg");
            }
        } catch (IOException e) {
            log.error("发送默认图片失败", e);
        }
    }

    private String getContentType(String fileName) {
        if (fileName.endsWith(".png")) return "image/png";
        if (fileName.endsWith(".gif")) return "image/gif";
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) return "image/jpeg";
        if (fileName.endsWith(".bmp")) return "image/bmp";
        return "image/jpeg";
    }

    /**
     * 上传文件（保持不变）
     */
    @PostMapping("/upload")
    public R<String> upLoad(MultipartFile file) {
        // 检查文件是否为空
        if (file.isEmpty()) {
            return R.error("文件不能为空");
        }

        //获取原始文件名
        String fileName = file.getOriginalFilename();
        if (fileName == null) {
            return R.error("文件名不能为空");
        }

        //获取到扩展名
        String suffix = fileName.substring(fileName.lastIndexOf("."));

        //生成唯一文件名
        String realFileName = UUID.randomUUID().toString() + suffix;

        //获取到配置文件中的文件储存地址，判断文件夹是否存在
        File dir = new File(imagePath);
        if (!dir.exists()) {
            //文件夹不存在则新建
            boolean created = dir.mkdirs(); // 使用mkdirs()创建多级目录
            if (created) {
                log.info("新建文件夹：{}", imagePath);
            } else {
                log.error("创建文件夹失败：{}", imagePath);
                return R.error("创建存储目录失败");
            }
        }

        //文件保存到指定目录下
        try {
            log.info("文件开始保存:{}", realFileName);
            File destFile = new File(imagePath + realFileName);
            file.transferTo(destFile);

            // 清除缓存中可能存在的同名文件（如果有的话）
            imageCache.remove(realFileName);

        } catch (IOException e) {
            log.error("文件保存失败: {}", e.getMessage());
            return R.error("文件上传失败");
        }

        //把文件名响应给客户端
        return R.success(realFileName);
    }

    /**
     * 清理缓存（可选方法，用于手动清理缓存）
     */
    public void clearCache() {
        imageCache.clear();
        log.info("图片缓存已清空");
    }

    /**
     * 从缓存中移除指定文件（可选方法）
     */
    public void removeFromCache(String fileName) {
        imageCache.remove(fileName);
        log.info("从缓存中移除文件: {}", fileName);
    }
}